-- Most of this config is taken from wiki for nvim-lspinstall.
-- Some additions from the lsp-status documentation.
-- local nvim_lsp = require "lspconfig"
local lsp_status = require "lsp-status"

-- We're getting diagnostics from nvim_lsp
lsp_status.config { diagnostics = false }
-- register lsp-status progress handler
lsp_status.register_progress()

-- Local variable to toggle whether to autoformat on save
local format_on_save = false
local toggle_format_on_save = function()
  if format_on_save then
    vim.cmd [[ autocmd! autofmt * ]]
    print "Disabled format on save"
    format_on_save = false
  else
    vim.cmd [[
      augroup autofmt
      autocmd!
      autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()
      augroup END
    ]]
    print "Enabled format on save"
    format_on_save = true
  end
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_map(mode, lhs, rhs, desc)
    -- opts = vim.tbl_extend("keep", opts, { silent = true, buffer = bufnr, desc = desc })
    local opts = { buffer = bufnr, silent = true, desc = desc }
    -- this uses `remap`, which is false by default, over `noremap`.
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  --Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_map("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", "goto declaration [LSP]")
  buf_map('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', "goto definition [LSP]")
  -- Why use telescope for this?
  -- buf_map("n", "gd", "<Cmd>Telescope lsp_definitions<CR>", "goto definition [LSP]")
  buf_map("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", "hover information [LSP]")
  -- gi overwrites "go to last insertion and insert", so use gI
  -- buf_set_keymap('n', 'gI', '<cmd>lua vim.lsp.buf.implementation()<CR>', {})
  buf_map("n", "gI", "<cmd>Telescope lsp_implementations<CR>", "list implementations [LSP]")
  buf_map("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", "signature help [LSP]")
  buf_map(
    "n",
    "<leader>lwa",
    "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",
    "add workspace folder [LSP]"
  )
  buf_map(
    "n",
    "<leader>lwr",
    "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
    "remove workspace folder [LSP]"
  )
  buf_map(
    "n",
    "<leader>lwl",
    "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
    "list workspace folders [LSP]"
  )
  -- buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', "type definitions [LSP]")
  -- <leader>D conflicts with treesitter "list definitions"
  buf_map("n", "<leader>lt", "<cmd>Telescope lsp_type_definitions<CR>", "type definitions [LSP]")
  buf_map("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", "rename [LSP]")
  buf_map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", "code actions [LSP]")
  buf_map("v", "<leader>ca", "<cmd>lua vim.lsp.buf.range_code_action()<CR>", "range code actions [LSP]")
  -- buf_set_keymap('n', '<leader>lgr', '<cmd>lua vim.lsp.buf.references()<CR>', "references [LSP]")
  buf_map("n", "<leader>lgr", "<cmd>Telescope lsp_references<CR>", "references [LSP]")
  buf_map("n", "<leader>lgs", "<cmd>Telescope lsp_document_symbols<CR>", "document symbols [LSP]")
  -- NOTE: It's not clear what the difference is between the dynamic and
  -- vanilla versions of workspace symbols.
  -- buf_set_keymap('n', '<leader>lgS', '<cmd>Telescope lsp_dynamic_workspace_symbols<CR>', "workspace symbols [LSP]")
  buf_map("n", "<leader>lgS", "<cmd>Telescope lsp_workspace_symbols<CR>", "workspace symbols [LSP]")
  buf_map(
    "n",
    "<leader>ld",
    "<cmd>Telescope lsp_document_diagnostics<CR>",
    "document diagnostics [LSP]"
  )
  buf_map(
    "n",
    "<leader>lD",
    "<cmd>Telescope lsp_workspace_diagnostics<CR>",
    "workspace diagnostics [LSP]"
  )
  buf_map(
    "n",
    "<leader>e",
    "<cmd>lua vim.diagnostic.open_float(nil, {source='always'})<CR>",
    "show line diagnostic [LSP]"
  )
  buf_map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", "goto previous diagnostic [LSP]")
  buf_map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", "goto next diagnostic [LSP]")
  buf_map("n", "<leader>lq", "<cmd>lua vim.diagnostic.setqflist()<CR>", "send diagnostics to quickfix [LSP]")
  buf_map("n", "<leader>lQ", "<cmd>lua vim.diagnostic.setloclist()<CR>", "send diagnostics to loclist [LSP]")
  -- These require textDocument/prepareCallHierarchy.
  -- litee-calltree provides these.
  -- TODO: Figure out what document capabilities can be queried to only set these when available.
  buf_map("n", "<leader>li", "<cmd>lua vim.lsp.buf.incoming_calls()<CR>", "incoming calls [LSP]")
  buf_map("n", "<leader>lo", "<cmd>lua vim.lsp.buf.outgoing_calls()<CR>", "outgoing calls [LSP]")

  if client.resolved_capabilities.document_formatting then
    buf_map("n", "<leader>l=", "<cmd>lua vim.lsp.buf.formatting()<CR>", "format buffer [LSP]")
    buf_map(
      "n",
      "<leader>t=",
      "<cmd>lua require('cfg.lsp').toggle_format_on_save()<CR>",
      "toggle format on save [LSP]"
    )
  elseif client.resolved_capabilities.document_range_formatting then
    buf_map("n", "<leader>l=", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", "format range [LSP]")
    -- NOTE: In this case a similar toggle functionality could be implemented,
    -- as toggle_format_on_save() but calling range_formatting instead
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
        augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold,CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
      ]],
      false
    )
  end

  -- code lens
  if client.resolved_capabilities.code_len then
    buf_map("n", "<leader>lL", "<cmd>lua vim.lsp.codelens.run()<CR>", "code lens [LSP]")
    vim.api.nvim_command[[autocmd CursorHold,CursorHoldI,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]]
  end

  -- Set up lsp_signature for the buffer.
  -- This must be done in here in order to use toggle_key.
  require("lsp_signature").on_attach({
    bind = true,
    hint_prefix = " ",
    toggle_key = "<C-s>",
  }, bufnr)

  -- Register client for messages and set up buffer autocommands to update the
  -- statusline and the current function.
  lsp_status.on_attach(client)
end

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

-- Turn off the virtual text diagnostics as there are often false positives and
-- it is visually noisy.
vim.diagnostic.config {
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = true,
}

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
  -- Add window/workDoneProgress capabilities from lsp-status
  capabilities = vim.tbl_extend("keep", capabilities, lsp_status.capabilities)
  return {
    capabilities = capabilities,
    -- map buffer local keybindings when the language server attaches
    on_attach = on_attach,
    -- added from nvim-lspconfig suggestions
    flags = {
      -- Should be default of 150 in nvim 0.7
      debounce_text_changes = 200,
    },
  }
end

-- lsp-installer
local lsp_installer = require "nvim-lsp-installer"
-- TODO: This approach is deprecated, see nvim-lsp-installer for update
lsp_installer.on_server_ready(function(server)
  local config = make_config()

  -- language specific config
  if server.name == "sumneko_lua" then
    config.settings = make_lua_settings()
  end
  if server.name == "pyright" then
    config.handlers = lsp_status.extensions.pyright.setup()
    config.settings = { python = { workspaceSymbols = { enabled = true } } }
  end
  if server.name == "sourcekit" then
    config.filetypes = { "swift", "objective-c", "objective-cpp" } -- we don't want c and cpp!
  end
  if server.name == "clangd" then
    config.filetypes = { "c", "cpp" } -- we don't want objective-c and objective-cpp!
  end

  -- server:setup should be the same as this:
  -- nvim_lsp[server].setup(config)
  server:setup(config)
  vim.cmd [[do User LspAttachBuffers]]
end)

local lsp = {}
-- export this so it can be passed to null-ls and rust-tools
lsp.on_attach = on_attach
lsp.toggle_format_on_save = toggle_format_on_save
return lsp
