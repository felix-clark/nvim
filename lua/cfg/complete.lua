vim.o.completeopt = "menu,menuone,noselect"

local cmp = require "cmp"
local sources = cmp.config.sources {
  { name = "nvim_lsp" },

  -- For vsnip user.
  { name = "vsnip" },

  -- For luasnip user.
  -- { name = 'luasnip' },

  -- For ultisnips user.
  -- { name = 'ultisnips' },

  -- orgmode
  { name = "orgmode" },

  -- For neovim lua files
  { name = "nvim_lua" },

  -- Lua require statements and module annotations
  {
    name = "lazydev",
    group_index = 0, -- set group index to 0 to skip loading LuaLS completions
  },

  -- Words already in buffer
  { name = "buffer" },

  { name = "path" },
}

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
    ["<C-Space>"] = cmp.mapping(
      cmp.mapping.complete {
        config = {
          sources = sources,
        },
      },
      { "i", "c" }
    ),
    ["<C-e>"] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    ["<CR>"] = cmp.mapping.confirm {
      -- could be Insert or Replace
      behavior = cmp.ConfirmBehavior.Insert,
      -- select = true,
      -- Only confirm explicitly selected items; it can be easy to forget to
      -- use C-e to quit the completion window.
      select = false,
    },
    ["<Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.complete_common_string()
      else
        fallback()
      end
    end,
  },
  sources = sources,
}
