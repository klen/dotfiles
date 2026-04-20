# AGENTS.md

Guidance for coding agents working in this dotfiles repository.

## Repository snapshot

- Personal dotfiles repo managed primarily with **GNU Stow** and **Ansible**.
- The repo root acts like a `$HOME` overlay: files such as `.zshrc`, `.vimrc`, `.config/**`,
  `.local/**`, and `bin/**` are intended to be symlinked into the real home directory.
- Main areas:
  - `bin/` — small shell/python/perl helper scripts
  - `.config/**` — app configs (Neovim, zsh, git, tmux, kitty, ghostty, etc.)
  - `.vim/**` — Vim config and plugins
  - `setup/**` — Ansible playbooks, vars, and templates
  - `Makefile` — operational entrypoints

## High-risk commands

Do **not** run these unless the user explicitly asks,
because they modify the real machine or can delete data:

- `make`
- `make update` — fetches and rebases against `origin/master`
- `make ansible`
- `make stow` / `make unstow`
- `make desktop`
- `make server`
- `make apps`
- `make apps-reset` — destructive; deletes app configs/databases
- Any `ansible-playbook` command without `--syntax-check`
- Any command that writes into `$HOME`, changes macOS defaults, or manages Docker containers

Prefer static inspection and syntax checks.

## Safe validation

Use focused checks for the files you changed.

### Shell / zsh

- Bash script: `bash -n path/to/script`
- Zsh config/script: `zsh -n path/to/file`

### Ansible

- Main playbook: `ansible-playbook -i inventory setup/playbook.yml --syntax-check`
- Desktop profile: `ansible-playbook -i inventory setup/desktop.yml --syntax-check`
- macOS server profile: `ansible-playbook -i inventory setup/server.mac.yml --syntax-check`
- Apps stack: `ansible-playbook -i inventory setup/server.apps.yml --syntax-check`

### Lua formatting

If `stylua` is available:

- `stylua --check path/to/file.lua`

## Editing guidelines

- Preserve the existing structure where repo paths mirror final paths in `$HOME`.
  - Example: if a file should end up at `~/.config/foo/config.toml`,
    store it here as `.config/foo/config.toml`.
- Keep changes minimal and local; this repo mixes many tools and personal preferences.
- Match the style already used in the surrounding file.
- Prefer updating existing configs/scripts over adding new tooling.
- When changing shell scripts, keep them portable and dependency-light
  unless the script already depends on a specific tool.
- When changing Ansible, keep tasks idempotent and avoid adding noisy `shell` usage
  when a module exists.
- Preserve executable bits for scripts in `bin/` if you rewrite them.

## Files and directories to avoid unless explicitly requested

- `.config/env.local` — local machine-specific environment/secrets
- `.config/smartcd/` — git submodule
- `.vim/plugged/` — vendored plugins
- `.config/opencode/node_modules/` and any `node_modules/`
- `.rumdl_cache/`, `.ansible/collections/`, `.ansible/roles/` if changes are not clearly intended
- `.config/nvim-old/` — legacy config archive; prefer `.config/nvim/`
- `.DS_Store` files and other machine-generated artifacts

## Repo-specific notes

- `Makefile` is operational, not just build tooling.
  Treat targets as machine-management tasks.
- `setup/server.apps.yml` manages a local Docker-based media/cloud stack
  and writes under `~/.local/share/server-apps`.
- `setup/vars.server.apps.yml` contains local defaults like paths, URL bases,
  and placeholder passwords; avoid changing them without user confirmation.
- `setup/vars.yml` contains user-specific SSH/home settings; do not change those casually.
- There is no obvious CI in `.github/workflows/`;
  rely on targeted syntax checks instead of assuming a full test suite.

## Good defaults for agents

1. Inspect first.
2. Edit only the relevant config/script.
3. Run the narrowest possible syntax check.
4. Report any command you skipped because it is machine-affecting or destructive.
