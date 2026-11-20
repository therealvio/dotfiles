#!/usr/bin/env bash
# Render every chezmoi target once per fixture in tests/fixtures/, then
# syntax-check the output. Uses test data and a fake 1Password CLI, so it
# never reads your real chezmoi config, state, or secrets.
set -euo pipefail

repo="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
tests="$repo/tests"
work_dir="$(mktemp -d)"
trap 'rm -rf "$work_dir"' EXIT

failures=0
fail() {
  echo "FAIL [$fixture] $*" >&2
  failures=$((failures + 1))
}

check_file() {
  local file="$1" rel="${1#"$out"/}"
  case "$rel" in
    .zshrc | .zprofile)
      zsh -n "$file" 2>"$work_dir/err" || fail "$rel: $(cat "$work_dir/err")" ;;
    *.json)
      jq empty "$file" 2>"$work_dir/err" || fail "$rel: $(cat "$work_dir/err")" ;;
    *.toml)
      python3 -I -c 'import sys, tomllib; tomllib.load(open(sys.argv[1], "rb"))' "$file" \
        2>"$work_dir/err" || fail "$rel: $(tail -n1 "$work_dir/err")" ;;
    .gitconfig | .gitconfig-*)
      git config --file "$file" --list >/dev/null 2>"$work_dir/err" \
        || fail "$rel: $(cat "$work_dir/err")" ;;
  esac
}

# The init template prompts for its data, so it needs simulated answers.
init_args=(--init --promptBool "Is this a work device=true")
for prompt in "Personal Private ECR registry URL:" "Government Name" \
  "Work email address" "Workplace name" "Workplace Private ECR registry URL"; do
  init_args+=(--promptString "$prompt=test")
done
fixture="init"
out="$work_dir"
if chezmoi execute-template "${init_args[@]}" <"$repo/.chezmoi.toml.tmpl" >"$work_dir/init.toml" \
  2>"$work_dir/err"; then
  check_file "$work_dir/init.toml"
else
  fail ".chezmoi.toml.tmpl: $(cat "$work_dir/err")"
fi

for fixture_file in "$tests"/fixtures/*.toml; do
  fixture="$(basename "$fixture_file" .toml)"
  config="$work_dir/$fixture-config.toml"
  out="$work_dir/$fixture-out"
  mkdir -p "$out"

  # The onepassword section needs an absolute path, so add it at run time.
  { cat "$fixture_file"; printf '\n[onepassword]\n    command = "%s"\n' "$tests/fake-op"; } >"$config"

  if ! chezmoi archive \
    --config "$config" \
    --source "$repo" \
    --destination "$work_dir/$fixture-home" \
    --persistent-state "$work_dir/$fixture-state.boltdb" \
    --format tar --output "$work_dir/$fixture.tar" 2>"$work_dir/err"; then
    fail "chezmoi archive: $(cat "$work_dir/err")"
    continue
  fi
  tar -xf "$work_dir/$fixture.tar" -C "$out"

  count=0
  while IFS= read -r -d '' file; do
    check_file "$file"
    count=$((count + 1))
  done < <(find "$out" -type f -print0)
  echo "ok [$fixture] rendered $count files"
done

if ((failures > 0)); then
  echo "$failures check(s) failed" >&2
  exit 1
fi
