require('plugins')
require('lsp')
require('global')

vim.api.nvim_command[[
  highlight LightspeedLabel ctermfg=blue
  highlight LightspeedLabelOverlapped ctermfg=yellow
  highlight LightspeedShortcut ctermfg=yellow ctermbg=NONE
]]

