local DIAGNOSTIC_ICONS = {
  error = " ",
  warn = " ",
  warning = " ",
  info = " ",
  hint = " ",
}

return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  event = "VeryLazy",
  keys = {
    { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
    { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Previous buffer" },
    -- { "<leader>bd", "<Cmd>bd<CR>", desc = "Delete Buffer" },
    { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
    { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
    { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete other buffers" },
    { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete buffers to the right" },
    { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete buffers to the left" },
    -- { "<leader>b1", "<Cmd>BufferLineGoToBuffer 1<CR>", desc = "Go to buffer 1" },
    -- { "<leader>b2", "<Cmd>BufferLineGoToBuffer 2<CR>", desc = "Go to buffer 2" },
    -- { "<leader>b3", "<Cmd>BufferLineGoToBuffer 3<CR>", desc = "Go to buffer 3" },
    -- { "<leader>b4", "<Cmd>BufferLineGoToBuffer 4<CR>", desc = "Go to buffer 4" },
    -- { "<leader>b5", "<Cmd>BufferLineGoToBuffer 5<CR>", desc = "Go to buffer 5" },
    -- { "<leader>b6", "<Cmd>BufferLineGoToBuffer 6<CR>", desc = "Go to buffer 6" },
    -- { "<leader>b7", "<Cmd>BufferLineGoToBuffer 7<CR>", desc = "Go to buffer 7" },
    -- { "<leader>b8", "<Cmd>BufferLineGoToBuffer 8<CR>", desc = "Go to buffer 8" },
    -- { "<leader>b9", "<Cmd>BufferLineGoToBuffer 9<CR>", desc = "Go to buffer 9" },
    { "<leader>bb", "<Cmd>BufferLineGoToBuffer -1<CR>", desc = "Go to last buffer" },
  },
  opts = {

    highlights = {
      background = { bg = "none" },
      fill = { bg = "#23273F" },
      -- buffer_selected = { bg = "none", fg = "#fab387" },
      -- buffer_visible = { bg = "none", fg = "#a6adc8" },
      close_button = { bg = "none" },
      close_button_selected = { bg = "none" },
      close_button_visible = { bg = "none" },
      duplicate = { bg = "none" },
      duplicate_selected = { bg = "none" },
      duplicate_visible = { bg = "none" },
      error = { bg = "none" },
      error_selected = { bg = "none" },
      error_visible = { bg = "none" },
      hint = { bg = "none" },
      hint_selected = { bg = "none" },
      hint_visible = { bg = "none" },
      indicator_selected = { bg = "none" },
      indicator_visible = { bg = "none" },
      info = { bg = "none" },
      info_selected = { bg = "none" },
      info_visible = { bg = "none" },
      modified = { bg = "none" },
      modified_selected = { bg = "none" },
      modified_visible = { bg = "none" },
      numbers = { bg = "none" },
      numbers_selected = { bg = "none" },
      numbers_visible = { bg = "none" },
      offset_separator = { bg = "none" },
      pick = { bg = "none" },
      pick_selected = { bg = "none" },
      pick_visible = { bg = "none" },
      separator = { fg = "#23273F" },
      separator_selected = { fg = "#23273F" },
      separator_visible = { fg = "#23273F" },
      tab = { bg = "none" },
      tab_close = { bg = "none" },
      tab_selected = { bg = "none" },
      tab_separator = { bg = "none" },
      tab_separator_selected = { bg = "none" },
      trunc_marker = { bg = "none" },
      warning = { bg = "none" },
      warning_selected = { bg = "none" },
      warning_visible = { bg = "none" },
    },

    options = {
      -- Set to "tabs" to only show tabpages instead of buffers
      mode = "buffers", -- "buffers" | "tabs"

      -- Style options
      separator_style = "slant", -- "slant" | "slope" | "thick" | "thin" | "padded_slant"
      -- separator_style = { "", "" },
      always_show_bufferline = false,

      -- Icons and visual elements
      show_buffer_close_icons = true,
      show_close_icon = true,
      show_tab_indicators = true,
      color_icons = true,

      -- Buffer numbering
      numbers = "ordinal", -- "none" | "ordinal" | "buffer_id" | function

      -- setting the Close delete buffer command
      close_command = ":lua Snacks.bufdelete.delete()",

      -- Sorting
      sort_by = "id", -- "id" | "extension" | "relative_directory" | "directory" | "tabs"

      -- LSP diagnostics integration (works seamlessly with Neovim 0.11+ native LSP)
      diagnostics = "nvim_lsp", -- Uses vim.diagnostic API automatically
      diagnostics_update_in_insert = false,
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        return " " .. (DIAGNOSTIC_ICONS[level] or " ") .. count
      end,
      -- Sidebar integration (for file explorers)
      offsets = {
        {
          filetype = "neo-tree",
          text = "Neo-tree",
          text_align = "left",
          separator = true,
        },
        {
          filetype = "NvimTree",
          text = "NvimTree",
          text_align = "left",
          separator = true,
        },
      },

      -- Hover events (requires nvim 0.8+)
      hover = {
        enabled = true,
        delay = 200,
        reveal = { "close" },
      },

      -- Custom filtering
      custom_filter = function(buf_number, buf_numbers)
        -- Filter out filetypes you don't want to see
        local filetype = vim.bo[buf_number].filetype
        if filetype == "qf" or filetype == "help" then
          return false
        end
        return true
      end,

      -- Buffer picking
      buffer_close_icon = "󰅖",
      modified_icon = "●",
      close_icon = "",
      left_trunc_marker = "",
      right_trunc_marker = "",

      -- Enforce regular tab size
      enforce_regular_tabs = false,
      tab_size = 21,
      max_name_length = 30,
      max_prefix_length = 30,
      truncate_names = true,

      -- Groups configuration
      groups = {
        options = {
          toggle_hidden_on_enter = true,
        },
        items = {
          {
            name = "Tests",
            highlight = { underline = true, sp = "blue" },
            priority = 2,
            icon = "",
            matcher = function(buf)
              return buf.name:match("%.test") or buf.name:match("%.spec")
            end,
          },
          {
            name = "Docs",
            highlight = { underline = true, sp = "green" },
            auto_close = false,
            matcher = function(buf)
              return buf.name:match("%.md") or buf.name:match("%.txt")
            end,
          },
        },
      },

      indicator = {
        icon = "",
        style = "none",
      },
    },

    -- Highlights will automatically derive from your colorscheme
    -- Only override specific highlights if needed for your colorscheme
  },

  config = function(_, opts)
    require("bufferline").setup(opts)

    -- Fix bufferline when restoring a session
    vim.api.nvim_create_autocmd("BufAdd", {
      callback = function()
        vim.schedule(function()
          pcall(nvim_bufferline)
        end)
      end,
    })

    -- Enhanced integration with Neovim 0.11+ LSP
    -- Automatically refresh bufferline when diagnostics change
    vim.api.nvim_create_autocmd("DiagnosticChanged", {
      callback = function()
        vim.schedule(function()
          -- Use vim.cmd to refresh bufferline instead of the non-existent API
          vim.cmd("redrawtabline")
        end)
      end,
    })

    -- Optional: Handle LSP attach/detach for better integration
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client:supports_method("textDocument/publishDiagnostics") then
          -- Bufferline will automatically pick up diagnostics via vim.diagnostic
          vim.schedule(function()
            vim.cmd("redrawtabline")
          end)
        end
      end,
    })
  end,
}
