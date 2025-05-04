#!/bin/sh

# exit immediately if password-manager-binary is already in $PATH
# Password manager is 1Password
type op >/dev/null 2>&1 && exit

case "$(uname -s)" in
Darwin)
    # commands to install password-manager-binary on Darwin
    brew install --cask 1password
    brew install --cask 1password-cli
    ;;
*)
    echo "unsupported OS"
    exit 1
    ;;
esac
