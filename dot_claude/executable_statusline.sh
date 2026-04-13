#!/usr/bin/env bash
# Claude Code statusline script
# Displays: [session_name] current_directory [git branch] [ctx:%] ➜

# Read JSON input piped from Claude Code containing workspace and session metadata
input=$(cat)

# Extract workspace and session information from JSON input
cwd=$(echo "$input" | jq -r '.workspace.current_dir')                      # Current working directory
session_name=$(echo "$input" | jq -r '.session_name // empty')             # Named session (if exists)
context_remaining=$(echo "$input" | jq -r '.context_window.remaining_percentage // empty')  # % of context window remaining

# Get git branch information if in a git repository
git_info=""
if git -c core.fileMode=false rev-parse --git-dir > /dev/null 2>&1; then
    # Try to get branch name, fallback to commit hash if detached HEAD
    branch=$(git -c core.fileMode=false symbolic-ref --short HEAD 2>/dev/null || git -c core.fileMode=false rev-parse --short HEAD 2>/dev/null)
    # Format git info with cyan color: "git <branch>"
    [ -n "$branch" ] && git_info=" $(printf '\033[0;36m')git $(printf '\033[0m')$branch"
fi

# Replace home directory with ~ for cleaner display
display_dir="${cwd/#$HOME/\~}"

# Build the status line with ANSI color codes
status_line=""

# Add session name if present (magenta/purple)
[ -n "$session_name" ] && status_line="$(printf '\033[0;35m')$session_name$(printf '\033[0m') "

# Add directory path (cyan) and git info
status_line="${status_line}$(printf '\033[0;36m')${display_dir}$(printf '\033[0m')${git_info}"

# Add context window remaining percentage (yellow) if available
[ -n "$context_remaining" ] && status_line="${status_line} $(printf '\033[0;33m')ctx:$(printf '%.0f' "$context_remaining")%$(printf '\033[0m')"

# Add sandbox status indicator (green if enabled, red if disabled)
projdir=$(echo "$input" | jq -r '.workspace.project_dir // empty')
if [ -n "$projdir" ] && [ "$(jq -r '.sandbox.enabled // false' "$projdir/.claude/settings.local.json" 2>/dev/null)" = "true" ]; then
  status_line="$status_line $(printf '\033[32m 󰒃 sandbox\033[0m')"
else
  status_line="$status_line $(printf '\033[31m ✗ sandbox\033[0m')"
fi

# Add prompt arrow (green)
status_line="${status_line} $(printf '\033[0;32m')➜$(printf '\033[0m')"

# Output the final status line
echo "$status_line"
