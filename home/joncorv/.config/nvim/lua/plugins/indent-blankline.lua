return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "HiPhish/rainbow-delimiters.nvim",
  },
  keys = {
    {
      "<leader>ug",
      function()
        local ibl = require("ibl")
        local enabled = vim.g.ibl_enabled
        if enabled == false then
          ibl.setup_buffer(0, { enabled = true })
          vim.g.ibl_enabled = true
          vim.notify("Indent guides enabled", vim.log.levels.INFO)
        else
          ibl.setup_buffer(0, { enabled = false })
          vim.g.ibl_enabled = false
          vim.notify("Indent guides disabled", vim.log.levels.INFO)
        end
      end,
      desc = "Toggle Indention [G]uides",
    },
  },
  config = function()
    local highlight = {
      "RainbowRed",
      "RainbowYellow",
      "RainbowBlue",
      "RainbowOrange",
      "RainbowGreen",
      "RainbowViolet",
      "RainbowCyan",
    }

    local hooks = require("ibl.hooks")

    -- Create highlight groups that reset when colorscheme changes
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      -- Rainbow colors for scope highlighting
      vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
      vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
      vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
      vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
      vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
      vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
      vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
    end)

    -- Configure rainbow-delimiters integration
    vim.g.rainbow_delimiters = { highlight = highlight }

    -- Setup indent-blankline
    require("ibl").setup({
      indent = {
        char = "▏",
        tab_char = "▏",
        smart_indent_cap = true,
      },
      scope = {
        enabled = true,
        show_start = true,
        show_end = true,
        highlight = highlight,
        priority = 500,
        include = {
          node_type = {
            ["*"] = { "*" },
          },
        },
      },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "snacks_dashboard",
          "snacks_notif",
          "snacks_terminal",
          "snacks_win",
        },
        buftypes = {
          "terminal",
          "nofile",
        },
      },
    })

    -- Integrate with rainbow-delimiters for scope highlighting
    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

    -- Vue-specific configuration for injected languages
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "vue",
      callback = function()
        require("ibl").setup_buffer(0, {
          scope = {
            injected_languages = true,
          },
        })
      end,
    })

    -- Initialize toggle state
    vim.g.ibl_enabled = true
  end,
}
