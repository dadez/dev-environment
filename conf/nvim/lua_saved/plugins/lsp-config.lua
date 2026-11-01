-- avoid displaying diagnostics on the lines
-- https://github.com/LazyVim/LazyVim/discussions/54#discussioncomment-4675766
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        virtual_text = false,
      },
    },
  },
}
