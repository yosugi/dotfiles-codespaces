#!/bin/bash
set -e

echo "Setting up dotfiles and tools..."

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Dotfiles to link
DOTFILES=(
  ".vimrc"
  ".bash_profile"
  ".gitconfig"
  ".gitignore"
)

for file in "${DOTFILES[@]}"; do
  src="$DOTFILES_DIR/$file"
  dest="$HOME/$file"

  if [ -f "$src" ]; then
    ln -sf "$src" "$dest"
    echo "Linked $file"
  else
    echo "Warning: $file not found in repo"
  fi
done

echo "Installing cli tools..."

sudo apt-get update -qq

# Tools to install
COMMANDS=(
  "fzf"
  "ripgrep"
  "tig"
)

for cmd in "${COMMANDS[@]}"; do
  if ! command -v "$cmd" &> /dev/null; then
    sudo apt-get install -y "$cmd"
    echo "Installed $cmd"
  else
    echo "$cmd already installed"
  fi
done

# ------------------------------
# 3. Vim プラグインのインストール
# ------------------------------
echo "Installing vim plugins..."

VIM_PLUGIN_DIR="$HOME/.vim/pack/plugins/start"
mkdir -p "$VIM_PLUGIN_DIR"
cd "$VIM_PLUGIN_DIR"

PLUGINS=(
  "https://github.com/junegunn/fzf.git"
  "https://github.com/junegunn/fzf.vim.git"
  "https://github.com/machakann/vim-sandwich.git"
  "https://github.com/yosugi/tcvime.git"
)

for url in "${PLUGINS[@]}"; do
  name=$(basename "$url" .git)
  if [ ! -d "$name" ]; then
    git clone --depth=1 "$url" &
  else
    echo "$name already cloned"
  fi
done

wait
echo "Vim plugins installed."

echo "All setup complete."

