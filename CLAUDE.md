# CLAUDE.md

This is a personal dotfiles repository managed by [chezmoi](https://www.chezmoi.io/). It contains configuration files, shell setup, git config, and tool configs for a macOS development environment.

## Tooling

- Use ripgrep (command: rg) to perform code searching

## Build, Test, and Lint Commands
- This repository does not contain build, test, or lint commands. It is a dotfiles/config management repo maintained by [chezmoi](https://www.chezmoi.io/quick-start/).
- To apply changes, use `chezmoi apply`.
- For template rendering, use `chezmoi execute-template`.

## High-Level Architecture
- All configuration files (dotfiles) are managed and templated by chezmoi.
- Templates use Go templating syntax and can prompt for variables during initialization (see `.chezmoi.toml.tmpl`).
- Key config files include shell (`dot_zshrc`), git (`dot_gitconfig.tmpl`, `dot_gitconfig-work.tmpl`), editor, cloud, and tool configs under `dot_config/`.
- Private and work-specific settings are handled via template conditionals and prompts.
- Some scripts (e.g., `.install-password-manager.sh`) automate environment setup for tools like 1Password.

## Key Conventions
- All dotfiles are prefixed with `dot_` and use `.tmpl` for templates.
- Git configuration uses aliases and includes work-specific settings if `workDevice` is true.
- Shell config loads plugins for common tools (docker, git, mise, etc.) and sets up paths for GNU utilities and Rancher Desktop.
- Sensitive/private configs are stored in `private_` files and directories.
- Use aliases defined in `dot_gitconfig.tmpl` for common git operations (e.g., `git fp`, `git amend`).

## Context7 MCP

Always use Context7 MCP for library/API documentation, code generation, and setup or configuration steps without being explicitly asked.

Use the following libraries for Context7:

- /twpayne/chezmoi
- /wezterm/wezterm
- /websites/chezmoi_io
- /websites/wezterm
