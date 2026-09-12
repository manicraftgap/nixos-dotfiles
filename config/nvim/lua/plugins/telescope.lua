return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")
      local themes = require("telescope.themes")
      telescope.setup(themes.get_dropdown({
        defaults = {
          path_display = { "truncate" },
          prompt_prefix = " 🔍 ",
          selection_caret = "  ",
        },
        pickers = {
          buffers = {
            sort_lastused = true,
            ignore_current_buffer = true,
          },
        },
      }))

      local map = vim.keymap.set
      map("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
      map("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind by [G]rep" })
      map("n", "<leader>fb", builtin.buffers, { desc = "[F]ind Open [B]uffers" })
      map("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp Tags" })
      map("n", "<leader>lr", builtin.lsp_references, { desc = "[L]SP Find [R]eferences" })
      map("n", "<leader>ld", builtin.lsp_definitions, { desc = "[L]SP Go to [D]efinition" })
      map("n", "<leader>ds", builtin.lsp_document_symbols, { desc = "[D]ocument [S]ymbols" })

      map("n", "<leader>en", function()
        builtin.find_files({
          cwd = vim.fn.stdpath("config"),
        })
      end, { desc = "[E]dit [N]eovim Config" })
    end,
  },
}
