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
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  -- buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap("n", "gd", "<Cmd>Telescope lsp_definitions<CR>", opts)
  buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
  -- gi overwrites "go to last insertion and insert", so use gI
  -- buf_set_keymap('n', 'gI', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap("n", "gI", "<cmd>Telescope lsp_implementations<CR>", opts)
  buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  buf_set_keymap("n", "<leader>lwa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<leader>lwr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  buf_set_keymap(
    "n",
    "<leader>lwl",
    "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
    opts
  )
  -- buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap("n", "<leader>D", "<cmd>Telescope lsp_type_definitions<CR>", opts)
  buf_set_keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  -- buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap("n", "<leader>ca", "<cmd>Telescope lsp_code_actions<CR>", opts)
  -- Need to escape out of visual mode within the telescope prompt
  buf_set_keymap("v", "<leader>ca", "<cmd>Telescope lsp_range_code_actions<CR><esc>", opts)
  -- buf_set_keymap('n', '<leader>lgr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap("n", "<leader>lgr", "<cmd>Telescope lsp_references<CR>", opts)
  buf_set_keymap("n", "<leader>lgs", "<cmd>Telescope lsp_document_symbols<CR>", opts)
  -- NOTE: It's not clear what the difference is between the dynamic and
  -- vanilla versions of workspace symbols.
  -- buf_set_keymap('n', '<leader>lgS', '<cmd>Telescope lsp_dynamic_workspace_symbols<CR>', opts)
  buf_set_keymap("n", "<leader>lgS", "<cmd>Telescope lsp_workspace_symbols<CR>", opts)
  buf_set_keymap("n", "<leader>ld", "<cmd>Telescope lsp_document_diagnostics<CR>", opts)
  buf_set_keymap("n", "<leader>lD", "<cmd>Telescope lsp_workspace_diagnostics<CR>", opts)
  buf_set_keymap(
    "n",
    "<leader>e",
    "<cmd>lua vim.diagnostic.open_float(nil, {source='always'})<CR>",
    opts
  )
  buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
  buf_set_keymap("n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<leader>l=", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    buf_set_keymap(
      "n",
      "<leader>t=",
      "<cmd>lua require('cfg.lsp').toggle_format_on_save()<CR>",
      opts
    )
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<leader>l=", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
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

-- Turn off the virtual text as there are often false positives
vim.diagnostic.config {
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = true,
}

-- Configure lua language server for neovim development
local lua_settings = {
  Lua = {
    runtime = {
      -- LuaJIT in the case of Neovim
      version = "LuaJIT",
      path = vim.split(package.path, ";"),
    },
    diagnostics = {
      -- Get the language server to recognize the `vim` global
      globals = { "vim" },
    },
    workspace = {
      -- Make the server aware of Neovim runtime files
      library = {
        [vim.fn.expand "$VIMRUNTIME/lua"] = true,
        [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
      },
    },
    -- Do not send telemetry data containing a randomized but unique identifier
    telemetry = {
      enable = false,
    },
  },
}

-- config that activates keymaps and enables snippet support
local function make_config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  -- advertise completion capabilities.
  -- This includes snippet support.
  capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
  -- Add window/workDoneProgress capabilities from lsp-status
  capabilities = vim.tbl_extend("keep", capabilities, lsp_status.capabilities)
  return {
    capabilities = capabilities,
    -- map buffer local keybindings when the language server attaches
    on_attach = on_attach,
    -- added from nvim-lspconfig suggestions
    flags = {
      debounce_text_changes = 400,
    },
  }
end

-- lsp-installer
local lsp_installer = require "nvim-lsp-installer"
lsp_installer.on_server_ready(function(server)
  local config = make_config()

  -- language specific config
  if server.name == "sumneko_lua" then
    config.settings = lua_settings
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
