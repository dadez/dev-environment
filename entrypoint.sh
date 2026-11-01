#!/usr/bin/bash

## based on https://github.com/okovalov/my_lazyvim_docker/

NVIM_CONFIG_DIR="/home/dadez/.config/nvim"
NVIM_SHARE_DIR="/home/dadez/.local/share/nvim"
NVIM_STATE_DIR="/home/dadez/.local/state/nvim"
NVIM_CACHE_DIR="/home/dadez/.cache/nvim"

# We need to check if the volume was just created and needs initialization
if [ ! -d "$NVIM_CONFIG_DIR/lua" ]; then
  echo "=== First run: Initializing LazyVim with default config ==="

  # Remove existing content if any (volume might be empty but dir exists)
  rm -rf "$NVIM_CONFIG_DIR" 2>/dev/null || true
  rm -rf "$NVIM_SHARE_DIR" 2>/dev/null || true
  rm -rf "$NVIM_STATE_DIR" 2>/dev/null || true
  rm -rf "$NVIM_CACHE_DIR" 2>/dev/null || true

  git clone https://github.com/LazyVim/starter "$NVIM_CONFIG_DIR"

  rm -rf "$NVIM_CONFIG_DIR/.git"

  echo "=== Default LazyVim Initialization complete! ==="
fi

if [ -d "/tmp/lua_saved" ]; then
  echo "Copying custom configuration from /tmp/lua_saved..."
  mkdir -p "$NVIM_CONFIG_DIR/lua"

  # copy with overwrite
  cp -r /tmp/lua_saved/* "$NVIM_CONFIG_DIR/lua/" 2>/dev/null || true

  echo "=== Custom LazyVim Initialization complete! ==="
fi

## zsh history
if [ ! -d "/home/dadez/.local/state/zsh" ]; then
  mkdir -vp /home/dadez/.local/state/zsh
fi

# exec CMD
exec "$@"
