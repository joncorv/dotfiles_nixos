vim.lsp.config("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = {
      diagnostics = {
        enable = false,
      },
      checkOnSave = {
        command = "cargo check",
      },
      cargo = {
        allFeatures = true,
      },
    },
  },
})

vim.lsp.enable("rust_analyzer")

-- return {
--   "mrcjkb/rustaceanvim",
--   version = "^4",
--   lazy = false,
--   ft = { "rust" },
--   init = function()
--     vim.g.rustaceanvim = {
--       server = {
--         settings = {
--           ["rust-analyzer"] = {
--             checkOnSave = {
--               command = "clippy",
--             },
--           },
--         },
--       },
--     }
--   end,
-- }, {
--   "Saecki/crates.nvim",
--   ft = { "toml" },
--   config = function()
--     require("crates").setup({})
--   end,
-- }
