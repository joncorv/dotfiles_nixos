return {
  "folke/trouble.nvim",
  -- event = "VeryLazy",
  opts = {}, -- for default options, refer to the configuration section for custom setup.
  cmd = "Trouble",
  keys = {
    {
      "<leader>td",
      "<cmd>Trouble diagnostics toggle filter.buf=0 focus=true<cr>",
      desc = "[T]rouble [D]iagnostics Buffer",
    },
    {
      "<leader>tD",
      "<cmd>Trouble diagnostics toggle focus=true<cr>",
      desc = "[T]rouble [D]iagnostics Workspace",
    },
    {
      "<leader>cs",
      "<cmd>Trouble symbols toggle focus=false<cr>",
      desc = "[C]ode [Symbols (Trouble)",
    },
    {
      "<leader>cl",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP Definitions / references / ... (Trouble)",
    },
    {
      "<leader>tt",
      "<cmd>Trouble todo toggle filter.buf=0 focus=true<cr>",
      desc = "[T]rouble [T]odo Buffer",
    },
    {
      "<leader>tT",
      "<cmd>Trouble todo toggle focus=true<cr>",
      desc = "[T]rouble [T]odo Workspace",
    },
    -- {
    --   "<leader>xL",
    --   "<cmd>Trouble loclist toggle<cr>",
    --   desc = "Location List (Trouble)",
    -- },
    -- {
    --   "<leader>xQ",
    --   "<cmd>Trouble qflist toggle<cr>",
    --   desc = "Quickfix List (Trouble)",
    -- },
  },
}
