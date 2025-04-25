#!/usr/bin/env bash
set -e

DOTFILES_DIR="$HOME/dotfiles"
echo "🔄 Backing up dotfiles to $DOTFILES_DIR"

# List of home-rooted dotfiles to copy (stripped of leading dot)
files=(
  bashrc
  zshrc
  vimrc
  tmux.conf
  gitconfig
)

# List of config-dir files (with their relative paths under ~/.config)
config_files=(
  "nvim/init.vim"
  "kitty/kitty.conf"
)

# Copy single files from $HOME
for f in "${files[@]}"; do
  src="$HOME/.${f}"
  dst="$DOTFILES_DIR/$f"
  if [[ -f "$src" ]]; then
    echo "  → Copying $src"
    cp "$src" "$dst"
  else
    echo "  ⚠️  Skipping .${f} (not found)"
  fi
done

# Copy files under ~/.config
for rel in "${config_files[@]}"; do
  src="$HOME/.config/$rel"
  dst="$DOTFILES_DIR/.config/$rel"
  if [[ -f "$src" ]]; then
    echo "  → Copying $src"
    mkdir -p "$(dirname "$dst")"
    cp "$src" "$dst"
  else
    echo "  ⚠️  Skipping .config/$rel (not found)"
  fi
done

echo "✅ Backup complete!"

