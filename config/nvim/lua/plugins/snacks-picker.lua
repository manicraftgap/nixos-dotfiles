return {
  { "nvim-telescope/telescope.nvim", enabled = false },
  {
    "folke/snacks.nvim",
    opts = { picker = { layout = { preset = "dropdown" } } }, -- keeps the dropdown look
    keys = {
      {
        "<leader>ff",
        function()
          Snacks.picker.files()
        end,
        desc = "Find Files",
      },
      {
        "<leader>fg",
        function()
          Snacks.picker.grep()
        end,
        desc = "Find by Grep",
      },
      {
        "<leader>fb",
        function()
          Snacks.picker.buffers({ current = false })
        end,
        desc = "Open Buffers",
      },
      {
        "<leader>fh",
        function()
          Snacks.picker.help()
        end,
        desc = "Help Tags",
      },
      {
        "<leader>lr",
        function()
          Snacks.picker.lsp_references()
        end,
        desc = "LSP References",
      },
      {
        "<leader>ld",
        function()
          Snacks.picker.lsp_definitions()
        end,
        desc = "LSP Definitions",
      },
      {
        "<leader>ds",
        function()
          Snacks.picker.lsp_symbols()
        end,
        desc = "Document Symbols",
      },
      {
        "<leader>en",
        function()
          Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
        end,
        desc = "Edit Neovim Config",
      },
    },
  },
}
