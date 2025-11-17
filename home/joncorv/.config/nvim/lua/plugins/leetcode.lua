return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate html",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  opts = {
    lang = "python3",
    picker = { provider = "fzf-lua" },
    image_support = true,
    -- plugins = {
    --   non_standalone = false,
    -- },
    storage = {
      home = vim.fn.expand("~/Documents/leetcode_omakase"),
      --   cache = vim.fn.expand("~/.cache/nvim/leetcode"),
    },
  },
}
