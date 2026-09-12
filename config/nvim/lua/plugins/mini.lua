return {
  'nvim-mini/mini.nvim',
  version = '*', -- Uses the latest stable release tags
  config = function()
    -- Require mini.animate safely at the top level of config
    local animate = require('mini.animate')

    ---------------------------------------------------------------------------
    -- 1. Text Objects (mini.ai)
    --    Extends 'a' and 'i' behavior with smart quotes, brackets, and motions.
    ---------------------------------------------------------------------------
    require('mini.ai').setup({
      n_lines = 500, -- Range to search for text objects
      search_method = 'cover_or_next',
    })

    ---------------------------------------------------------------------------
    -- 2. Surround Actions (mini.surround)
    --    Add/delete/replace surroundings (sa = add, sd = delete, sr = replace)
    ---------------------------------------------------------------------------
    require('mini.surround').setup({
      mappings = {
        add = 'sa',            -- Add surrounding in Normal and Visual modes
        delete = 'sd',         -- Delete surrounding
        find = 'sf',           -- Find surrounding (to the right)
        find_left = 'sF',      -- Find surrounding (to the left)
        highlight = 'sh',      -- Highlight surrounding
        replace = 'sr',        -- Replace surrounding
        update_n_lines = 'sn', -- Update `n_lines`
      },
    })

    ---------------------------------------------------------------------------
    -- 3. Text Operators (mini.operators)
    --    Replace (gr), Multiply/Duplicate (gm), Exchange (gx), Evaluate (g=)
    ---------------------------------------------------------------------------
    require('mini.operators').setup({
      -- Evaluate text as Lua code
      evaluate = { prefix = 'g=' },
      -- Exchange text regions
      exchange = { prefix = 'gx' },
      -- Multiply/Duplicate text
      multiply = { prefix = 'gm' },
      -- Replace text with register content
      replace = { prefix = 'gr' },
      -- Sort text regions
      sort = { prefix = 'gs' },
    })

    ---------------------------------------------------------------------------
    -- 4. Autopairs (mini.pairs)
    --    Automatically inserts/deletes matching pairs as you type.
    ---------------------------------------------------------------------------
    require('mini.pairs').setup()

    ---------------------------------------------------------------------------
    -- 5. Bracket Navigation (mini.bracketed)
    --    Use `[` and `]` to navigate buffers ([b), windows ([w), diagnostics ([d)...
    ---------------------------------------------------------------------------
    require('mini.bracketed').setup({
      buffer     = { suffix = 'b', options = {} },
      comment    = { suffix = 'c', options = {} },
      conflict   = { suffix = 'x', options = {} },
      diagnostic = { suffix = 'd', options = {} },
      file       = { suffix = 'f', options = {} },
      jump       = { suffix = 'j', options = {} },
      location   = { suffix = 'l', options = {} },
      oldfile    = { suffix = 'o', options = {} },
      quickfix   = { suffix = 'q', options = {} },
      undo       = { suffix = 'u', options = {} },
      window     = { suffix = 'w', options = {} },
      yank       = { suffix = 'y', options = {} },
    })

    ---------------------------------------------------------------------------
    -- 6. Visual Animations (mini.animate)
    ---------------------------------------------------------------------------
    animate.setup({
      scroll = {
        enable = false,
      },
      cursor = {
        enable = true,
        timing = animate.gen_timing.linear({ duration = 100, unit = 'total' }),
      },
    })
  end,
}
