return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      automatic_installation = false,
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          mason = false,
        },
      },
    },
  },
}
