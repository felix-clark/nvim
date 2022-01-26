vim.o.completeopt = "menu,menuone,noselect"

local cmp = require "cmp"
cmp.setup {
  snippet = {
    expand = function(args)
      -- For `vsnip` user.
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` user.

      -- For `luasnip` user.
      -- require('luasnip').lsp_expand(args.body)

      -- For `ultisnips` user.
      -- vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  mapping = {
    -- add <C-j> and <C-k> to navigate menu without stretching fingers like C-n/p
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ['<C-CR>'] = cmp.mapping.confirm({
      -- could be Insert or Replace
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
    ["<Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ["<S-Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = "nvim_lsp" },

    -- For vsnip user.
    { name = "vsnip" },

    -- For luasnip user.
    -- { name = 'luasnip' },

    -- For ultisnips user.
    -- { name = 'ultisnips' },

    -- For neovim lua files
    { name = "nvim_lua" },

    -- Words already in buffer
    { name = "buffer" },

    { name = "path" },
  },
}
