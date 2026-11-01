-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

-- Add the path and name of the file top right of the split
opt.winbar = "%=%m %f"

-- clipboard
opt.clipboard = ""
-- opt.clipboard = "unnamedplus"
