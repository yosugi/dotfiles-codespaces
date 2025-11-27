# dotfiles for GitHub Codespaces

This repository sets up basic development environment configuration for use in GitHub Codespaces.

## Included files

- `.vimrc`
- `.bash_profile`
- `.gitconfig`
- `.gitignore`

## What it does

The `setup.sh` script:

1. Creates symbolic links from repository files to your `$HOME` directory
2. Installs the following Vim plugins under `~/.vim/pack/plugins/start/`:
   - [fzf](https://github.com/junegunn/fzf)
   - [fzf.vim](https://github.com/junegunn/fzf.vim)
   - [vim-sandwich](https://github.com/machakann/vim-sandwich)
   - [tcvime](https://github.com/yosugi/tcvime)
3. Installs [ccd](https://github.com/yosugi/ccd.zsh) (customized cd command, available as `,cd`)
4. Installs CLI tools: `fzf`, `ripgrep`, `fd-find`, `tig`

## Usage

Clone this repository as your Codespaces dotfiles repo.

GitHub Codespaces automatically executes `setup.sh` when present at the root of the repo.

## Notes

- `.bash_profile` is used instead of overwriting `.bashrc` directly to avoid clobbering Codespaces' default shell setup.

