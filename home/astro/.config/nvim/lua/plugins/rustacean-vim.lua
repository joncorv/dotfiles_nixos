return {
  {
    "mrcjkb/rustaceanvim",
    version = "^4",
    lazy = false,
    ft = { "rust" },
    init = function()
      vim.g.rustaceanvim = {
        server = {
          settings = {
            ["rust-analyzer"] = {
              checkOnSave = {
                command = "check",
              },
            },
          },
        },
      }
    end,
  },
  {
    "Saecki/crates.nvim",
    ft = { "toml" },
    config = function()
      require("crates").setup({})
    end,
  },
}
