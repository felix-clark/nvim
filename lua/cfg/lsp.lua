-- Most of this config is taken from wiki for nvim-lspinstall.
local nvim_lsp = require "lspconfig"

-- Local variable to toggle whether to autoformat on save
-- This is now handled by conform.nvim, but we'll keep this code commented for
-- now because it may be a useful reference for handling it manually.
-- local format_on_save = false
-- local toggle_format_on_save = function()
--   if format_on_save then
--     vim.api.nvim_del_augroup_by_name "autofmt"
--     print "Disabled format on save"
--     format_on_save = false
--   else
--     vim.api.nvim_create_augroup("autofmt", {})
--     vim.api.nvim_create_autocmd("BufWritePre", {
--       group = "autofmt",
--       -- 0 refers to the current buffer.
--       -- vim.fn.bufnr() should also work.
--       buffer = 0,
--       callback = function()
--         vim.lsp.buf.format()
--       end,
--     })
--     print "Enabled format on save"
--     format_on_save = true
--   end
-- end

-- Turn off the virtual text diagnostics as there are often false positives and
-- it is visually noisy.
vim.diagnostic.config {
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = true,
  -- use source = "if_many" to only show source when there are multiple. This
  -- is probably preferable in the long run when I'm not experimenting with
  -- different providers so much.
  float = { source = "always" },
}

-- global diagnostic keymaps independent of a LSP server
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "show line diagnostic" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "goto previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "goto next diagnostic" })
vim.keymap.set(
  "n",
  "<leader>lq",
  vim.diagnostic.setqflist,
  { desc = "send diagnostics to quickfix" }
)
vim.keymap.set(
  "n",
  "<leader>lQ",
  vim.diagnostic.setloclist,
  { desc = "send diagnostics to loclist" }
)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(ev)
  local bufnr = ev.buf
  local client = vim.lsp.get_client_by_id(ev.data.client_id)

  local function buf_map(mode, lhs, rhs, desc)
    local opts = { buffer = bufnr, silent = true, desc = desc }
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  local tele = require "telescope.builtin"

  -- NOTE: Omnifunc should not be used concurrently with nvim-cmp.
  -- Uncomment to enable completion triggered by <c-x><c-o>
  -- vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_map("n", "gD", vim.lsp.buf.declaration, "goto declaration [LSP]")
  buf_map("n", "gd", vim.lsp.buf.definition, "goto definition [LSP]")
  -- Why use telescope for this?
  -- buf_map("n", "gd", tele.lsp_definitions, "goto definition [LSP]")
  buf_map("n", "K", vim.lsp.buf.hover, "hover information [LSP]")
  -- gi overwrites "go to last insertion and insert", so use gI
  -- buf_set_keymap('n', 'gI', vim.lsp.buf.implementation, {})
  buf_map("n", "gI", tele.lsp_implementations, "list implementations [LSP]")
  buf_map("n", "<C-k>", vim.lsp.buf.signature_help, "signature help [LSP]")
  buf_map("n", "<leader>lwa", vim.lsp.buf.add_workspace_folder, "add workspace folder [LSP]")
  buf_map("n", "<leader>lwr", vim.lsp.buf.remove_workspace_folder, "remove workspace folder [LSP]")
  buf_map("n", "<leader>lwl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "list workspace folders [LSP]")
  -- buf_set_keymap('n', '<leader>D', vim.lsp.buf.type_definition, "type definitions [LSP]")
  -- <leader>D conflicts with treesitter "list definitions"
  buf_map("n", "<leader>lt", tele.lsp_type_definitions, "type definitions [LSP]")
  buf_map("n", "<leader>lr", vim.lsp.buf.rename, "rename [LSP]")
  buf_map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "code actions [LSP]")
  -- buf_set_keymap('n', '<leader>lgr', vim.lsp.buf.references, "references [LSP]")
  buf_map("n", "<leader>lgr", tele.lsp_references, "references [LSP]")
  buf_map("n", "<leader>lgs", tele.lsp_document_symbols, "document symbols [LSP]")
  buf_map("n", "<leader>lgS", tele.lsp_workspace_symbols, "workspace symbols [LSP]")
  -- These require textDocument/prepareCallHierarchy.
  -- litee-calltree provides these.
  -- TODO: Figure out what document capabilities can be queried to only set these when available.
  -- NOTE: There are telescope pickers for these.
  buf_map("n", "<leader>li", vim.lsp.buf.incoming_calls, "incoming calls [LSP]")
  buf_map("n", "<leader>lo", vim.lsp.buf.outgoing_calls, "outgoing calls [LSP]")
  -- litee-symboltree adjusts this behavior to open a tree
  buf_map("n", "<leader>ls", vim.lsp.buf.document_symbol, "open symbol tree [LSP]")

  -- NOTE: General formatting is done by <leader>= now, which should fallback
  -- to LSP formatting if no dedicated CLI program is used. This keybinding is
  -- left just in case I want to try to force the operation through LSP, for
  -- some reason.
  if client.server_capabilities.documentFormattingProvider then
    buf_map("n", "<leader>l=", function()
      vim.lsp.buf.format { async = true }
    end, "format buffer [LSP]")
  end

  -- Highlight symbol under cursor (if capabilities exist)
  -- Treesitter handles the highlighting of the same symbol elsewhere.
  if client.server_capabilities.documentHighlightProvider then
    -- The colors can be adjusted here, but LightYellow is too bright.
    -- These groups must be defined for buf.document_highlight to work, but
    -- they appear to be defined elsewhere because the CursorHold aucmd does
    -- function.
    -- vim.cmd [[
    --   hi! LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
    --   hi! LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
    --   hi! LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
    -- ]]
    vim.api.nvim_create_augroup("lsp_document_highlight", {
      clear = false,
    })
    vim.api.nvim_clear_autocmds {
      buffer = bufnr,
      group = "lsp_document_highlight",
    }
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = "lsp_document_highlight",
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      group = "lsp_document_highlight",
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end

  -- code lens
  -- NOTE: How do we check for capabilities in v0.8? Do we need to?
  -- if client.resolved_capabilities.code_len then
  -- buf_map("n", "<leader>lL", "<cmd>lua vim.lsp.codelens.run()<CR>", "code lens [LSP]")
  -- vim.api.nvim_command[[autocmd CursorHold,CursorHoldI,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]]
  -- end

  -- Set up lsp_signature for the buffer.
  -- This must be done in here in order to use toggle_key.
  require("lsp_signature").on_attach({
    bind = true,
    -- This should be toggled by toggle_key. Default to false because it's
    -- invasive, but allow C-s to turn it on.
    floating_window = false,
    hint_prefix = " ",
    toggle_key = "<C-s>",
  }, ev.buf)
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = on_attach,
})

-- Set the gutter diagnostics to use icons
-- local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Completion icons
local comp_icons = {
  Class = "",
  Color = "",
  Constant = "",
  Constructor = "",
  Enum = "了",
  EnumMember = "",
  Field = "",
  File = "",
  Folder = "",
  Function = "",
  Interface = "ﰮ",
  Keyword = "",
  Method = "ƒ",
  Module = "",
  Property = "",
  Snippet = "﬌",
  Struct = "",
  Text = "",
  Unit = "",
  Value = "",
  Variable = "",
}
local kinds = vim.lsp.protocol.CompletionItemKind
for i, kind in ipairs(kinds) do
  kinds[i] = comp_icons[kind] or kind
end

-- Lua language server configuration for neovim development
local function make_lua_settings()
  local runtime_path = vim.split(package.path, ";")
  table.insert(runtime_path, "lua/?.lua")
  table.insert(runtime_path, "lua/?/init.lua")

  local lua_settings = {
    Lua = {
      runtime = {
        -- LuaJIT in the case of Neovim
        version = "LuaJIT",
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  }
  return lua_settings
end

-- config that activates keymaps and enables snippet support
local function make_config()
  -- advertise completion capabilities.
  -- This includes snippet support.
  local capabilities = require("cmp_nvim_lsp").default_capabilities()
  return {
    capabilities = capabilities,
    -- map buffer local keybindings when the language server attaches
    -- on_attach = on_attach, -- this is for additional per-server hooks only
  }
end

local mason_lsp = require "mason-lspconfig"
mason_lsp.setup {
  -- bash requires npm/node which may not always be available.
  -- ensure_installed = { "lua_ls", "bashls" },
  ensure_installed = { "lua_ls", "ruff_lsp" },
  -- If enabled, this will install servers configured in lspconfig. Can
  -- also be set to exclude specific servers (e.g. "rust-analyzer").
  automatic_installation = false,
}

-- Package installation folder
local mason_install_root_dir = vim.fn.stdpath "data" .. "/mason"

-- This setup_handlers API is used in place of looping through
-- mason-lspconfig.get_installed_servers().
mason_lsp.setup_handlers {
  -- The first entry (without a key) will be the default handler and will be
  -- called for each installed server that doesn't have a dedicated handler.
  function(server_name)
    local config = make_config()
    nvim_lsp[server_name].setup(config)
  end,
  -- Targetted overrides are provided with keys for specific servers.
  -- Now leaning on lazydev to set up lua LS, but the pre-existing settings are
  -- still useful
  ["lua_ls"] = function()
    local config = make_config()
    config.settings = make_lua_settings()
    nvim_lsp.lua_ls.setup(config)
  end,
  ["pyright"] = function()
    local config = make_config()
    config.settings = { python = { workspaceSymbols = { enabled = true } } }
    nvim_lsp.pyright.setup(config)
  end,
}
