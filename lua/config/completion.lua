local cmp = require 'cmp'

local next = cmp.mapping(function(fallback)
  if cmp.visible() then
    cmp.select_next_item()
  elseif vim.fn["vsnip#available"]() == 1 then
    vim.fn.feedkeys(t("<Plug>(vsnip-expand-or-jump)"), "")
  else
    fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
  end
end, { "i", "s" })

local prev = cmp.mapping(function()
  if cmp.visible() then
    cmp.select_prev_item()
  elseif vim.fn["vsnip#jumpable"](-1) == 1 then
    vim.fn.feedkeys(t("<Plug>(vsnip-jump-prev)"), "")
  end
end, { "i", "s" })

cmp.setup({
  snippet = {
      expand = function(args)
        require'luasnip'.lsp_expand(args.body)
      end
  },
  mapping = {
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),

    ['<Tab>'] = next,
    ['<C-n>'] = next,

    ["<S-Tab>"] = prev,
    ["<C-p>"] = prev,

    ['<C-j>'] = cmp.mapping(function(fallback)
      if vim.fn['vsnip#available']() == 1 then
        vim.fn.feedkeys(t('<Plug>(vsnip-expand-or-jump)'), '')
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<C-k>'] = cmp.mapping(function(fallback)
      if vim.fn['vsnip#available']() == 1 then
        vim.fn.feedkeys(t('<Plug>(vsnip-jump-prev)'), '')
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'calc' },
    { name = 'path' },
  },
})
