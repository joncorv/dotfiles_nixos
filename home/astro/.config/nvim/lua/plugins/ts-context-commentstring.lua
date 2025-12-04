return {
  "JoosepAlviste/nvim-ts-context-commentstring",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    -- Set the global variable to skip the deprecated module
    vim.g.skip_ts_context_commentstring_module = true

    require("ts_context_commentstring").setup({
      enable_autocmd = false,
    })
  end,
}
