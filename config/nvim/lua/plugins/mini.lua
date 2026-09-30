return {
  "nvim-mini/mini.nvim",
  version = "*",
  config = function()
    local animate = require("mini.animate")

    require("mini.surround").setup() -- sa / sd / sr / sf / sF / sh / sn

    require("mini.operators").setup() -- gr replace, gx exchange, gm multiply, gs sort, g= evaluate

    -- same 12 targets as before, minus the two extras mini adds by default
    require("mini.bracketed").setup({
      indent = { suffix = "" },
      treesitter = { suffix = "" },
    })

    animate.setup({
      scroll = { enable = false },
      cursor = {
        enable = true,
        timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
      },
    })

    require("mini.hipatterns").setup({
      highlighters = {
        hex_color = require("mini.hipatterns").gen_highlighter.hex_color({ priority = 2000 }),
      },
    })
  end,
}
