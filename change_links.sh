#!/bin/bash
# 要处理的目录
target_dir="$HOME/.local/share/nvim/mason/bin"

for symlink in "$target_dir"/*; do
  if [ -L "$symlink" ]; then
    target_path=$(readlink "$symlink")
    if [[ "$target_path" == *".local/share"* ]]; then
      new_target_path=$(echo "$target_path" | sed "s|.*/.local/share|$HOME/.local/share|")
      echo "Old Path: $target_path"
      echo "New Path: $new_target_path"
      ln -sf "$new_target_path" "$symlink"
    fi
  fi
done
