#!/bin/bash

echo "🔗 Installing symlinks for dotfiles..."

# Array of source and target file pairs
declare -A files=(
  [".bashrc"]="$HOME/.bashrc"
  [".zshrc"]="$HOME/.zshrc"
  [".vimrc"]="$HOME/.vimrc"
  [".tmux.conf"]="$HOME/.tmux.conf"
  [".gitconfig"]="$HOME/.gitconfig"
  [".config/nvim/init.vim"]="$HOME/.config/nvim/init.vim"
  [".config/kitty/kitty.conf"]="$HOME/.config/kitty/kitty.conf"
)

for file in "${!files[@]}"; do
  src="$HOME/dotfiles/$file"
  dest="${files[$file]}"

  # Make sure destination directories exist
  mkdir -p "$(dirname "$dest")"

  # Backup existing files if needed
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    echo "📦 Backing up existing $dest to $dest.backup"
    mv "$dest" "$dest.backup"
  fi

  # Create symlink
  echo "🔗 Linking $src → $dest"
  ln -sf "$src" "$dest"
done

echo "✅ All dotfiles are now symlinked!"
