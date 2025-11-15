return {
  "nvim-treesitter/nvim-treesitter",
  -- event = "VeryLazy",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "markdown",
        "markdown_inline",
        "vue",
        "typescript",
        "javascript",
        "rust",
        "ron",
        "css",
        "python",
        "html",
        "json",
        "jsonc",
      },
      sync_install = false,
      auto_install = true,
      ignore_install = {},

      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    })
  end,
}
