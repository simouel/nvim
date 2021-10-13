require('plugins')
require('nvim-lspconfig')
require('config.compe')
require('config.global')
require('lualine').setup({options = {theme = 'gruvbox'}})

-- Prettier function for formatter
local prettier = function()
  return {
    exe = "prettier",
    args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0), "--double-quote" },
    stdin = true,
  }
end

require("formatter").setup({
  logging = false,
  filetype = {
    javascript = { prettier },
    json = { prettier },
    typescript = { prettier },
    html = { prettier },
    css = { prettier },
    scss = { prettier },
    markdown = { prettier },
  },
})

--vim.api.nvim_exec([[ 
-- autocmd ColorScheme * lua require'lightspeed'.init_highlight(true)
--]], false)

vim.api.nvim_command[[
  colorscheme gruvbox
  highlight LightspeedLabel ctermfg=blue
  highlight LightspeedLabelOverlapped ctermfg=yellow
  highlight LightspeedShortcut ctermfg=yellow ctermbg=NONE
]]
