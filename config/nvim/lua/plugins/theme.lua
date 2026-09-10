return {
  {
    "rrethy/base16-nvim",
    lazy = false,
    priority = 1000,
    config = function()
      local colors = {
        base00 = "#000000", -- Background
        base01 = "#0d0d0d", -- Panels / StatusLine
        base02 = "#1c1c1c", -- Selection
        base03 = "#666666", -- Comments
        base04 = "#e53935", -- Active line number / Accent
        base05 = "#999999", -- Default text
        base06 = "#ffffff", -- Functions / Methods
        base07 = "#ffffff", -- Special Keys
        base08 = "#e53935", -- Keywords / Tags / Imports
        base09 = "#e53935", -- Numbers / Constants
        base0A = "#ffffff", -- Classes / Types
        base0B = "#a8a8a8", -- Strings
        base0C = "#ffffff", -- Operators
        base0D = "#ffffff", -- Identifiers
        base0E = "#e53935", -- Conditionals / Return statements
        base0F = "#e53935", -- Warnings / Errors
      }

      require("base16-colorscheme").setup(colors)

      -- Darken floating window backgrounds and prompt text
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#000000", fg = "#ffffff" })
      vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#000000", fg = "#666666" })
      vim.api.nvim_set_hl(0, "NeoTreeFloatBorder", { bg = "#000000", fg = "#666666" })
      vim.api.nvim_set_hl(0, "NeoTreeTitleBar", { bg = "#1c1c1c", fg = "#ffffff", bold = true })

      vim.api.nvim_set_hl(0, "LineNr", { fg = "#444444" })
      vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#e53935", bold = true })
      vim.api.nvim_set_hl(0, "CursorLine", { bg = "#080808" })
      vim.api.nvim_set_hl(0, "NeoTreeFileName", { fg = "#cccccc" })
      vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = "#eeeeee", bold = true })
      vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { fg = "#e53935", bg = "#141414", bold = true })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function() end,
    },
  },
  {
    "nvim-mini/mini.nvim",
    main = "mini.hipatterns",
    opts = function()
      local hi = require("mini.hipatterns")
      return {
        highlighters = {
          hex_color = hi.gen_highlighter.hex_color({ priority = 2000 }),
        },
      }
    end,
  },
}
