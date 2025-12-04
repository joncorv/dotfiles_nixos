require("lsp.luals")
-- require("lsp.rust")
require("lsp.vue")
require("lsp.python")
vim.lsp.enable("nixd")
vim.lsp.enable("hyprls")

vim.lsp.config("*", {
  handlers = {
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = "rounded",
    }),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = "rounded",
    }),
  },
})

-- vim.lsp.enable("lua_ls", "vue", "rust", "rust_analyzer")

--  This function gets run when an LSP attaches to a particular buffer.
--    That is to say, every time a new file is opened that is associated with
--    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
--    function will be executed to configure the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
  callback = function(event)
    -- NOTE: Remember that Lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don't have to repeat yourself.
    --
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local map = function(keys, func, desc, mode)
      mode = mode or "n"
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    map("K", function()
      local params = vim.lsp.util.make_position_params()
      vim.lsp.buf_request(0, "textDocument/hover", params, vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }))
    end, "Hover with border")

    -- LSP keymaps
    map("<Leader>cr", vim.lsp.buf.rename, "[C]ode [R]ename Symbol")
    map("<Leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
    map("<Leader>cR", vim.lsp.buf.references, "[C]ode [R]eferences")
    map("<Leader>ci", vim.lsp.buf.implementation, "[C]ode [I]mplementation")
    map("<Leader>cd", vim.lsp.buf.definition, "[C]ode [D]efinition")
    map("<Leader>cD", vim.lsp.buf.declaration, "[C]ode [D]eclaration")
    -- map("gO", vim.lsp.buf.document_symbols, "Open Document Symbols")
    map("<Leader>cw", vim.lsp.buf.workspace_symbol, "[C]ode [W]orkspace Symbols")
    map("<Leader>ct", vim.lsp.buf.type_definition, "[C]ode [T]ype Definition")

    -- All my UI Diagnostic Toggles
    map("<leader>ul", vim.diagnostic.open_float, "[U]I [L]ine Diagnostics")
    map("<leader>uh", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, "Toggle Inlay [H]ints")

    map("<leader>uv", function()
      vim.diagnostic.config({
        virtual_text = not vim.diagnostic.config().virtual_text,
      })
    end, "Toggle [V]irtual text")

    -- This function resolves differences between neovim versions
    ---@param client vim.lsp.Client
    ---@param method vim.lsp.protocol.Method
    ---@param bufnr? integer some lsp support methods only in specific files
    ---@return boolean
    local function client_supports_method(client, method, bufnr)
      -- For Neovim 0.12+, use the modern API
      if vim.fn.has("nvim-0.12") == 1 then
        return client:supports_method(method, { bufnr = bufnr })
      elseif vim.fn.has("nvim-0.11") == 1 then
        return client:supports_method(method, bufnr)
      else
        return client.supports_method(method, { bufnr = bufnr })
      end
    end

    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if
      client
      and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
    then
      local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
        end,
      })
    end

    -- -- Toggle diagnostic Hover
    -- local diagnostic_hover_enabled = true -- Start enabled by default
    -- local diagnostic_hover_augroup = vim.api.nvim_create_augroup("diagnostic-hover", { clear = true })
    --
    -- -- Set up the initial autocmd since it's enabled by default
    -- vim.api.nvim_create_autocmd("CursorHold", {
    --   group = diagnostic_hover_augroup,
    --   callback = function()
    --     local opts = {
    --       focusable = false,
    --       close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
    --       border = "rounded",
    --       source = "always",
    --       prefix = " ",
    --     }
    --     vim.diagnostic.open_float(nil, opts)
    --   end,
    -- })
    --
    -- map("<leader>uD", function()
    --   diagnostic_hover_enabled = not diagnostic_hover_enabled
    --
    --   if diagnostic_hover_enabled then
    --     vim.api.nvim_create_autocmd("CursorHold", {
    --       group = diagnostic_hover_augroup,
    --       callback = function()
    --         local opts = {
    --           focusable = false,
    --           close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
    --           border = "rounded",
    --           source = "always",
    --           prefix = " ",
    --         }
    --         vim.diagnostic.open_float(nil, opts)
    --       end,
    --     })
    --     vim.notify("Diagnostic hover on cursor hold enabled", vim.log.levels.INFO)
    --   else
    --     vim.api.nvim_clear_autocmds({ group = diagnostic_hover_augroup })
    --     vim.notify("Diagnostic hover on cursor hold disabled", vim.log.levels.INFO)
    --   end
    -- end, "Toggle Auto [D]iagnostic Hover")
    ----
    ---
  end,
})
