return {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function(_, opts)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "nix",
      callback = function()
        vim.bo.commentstring = "# %s"
      end,
    })

    require("Comment").setup(opts)
  end,
}
