local utils = require('utils')
vim.g.mapleader = ','

local cmd = vim.cmd
local indent = 4

cmd 'syntax enable'
cmd 'filetype plugin indent on'

utils.opt('b', 'expandtab', true)
utils.opt('b', 'shiftwidth', indent)
utils.opt('b', 'smartindent', true)
utils.opt('b', 'tabstop', indent)
utils.opt('o', 'scrolloff', 4)
utils.opt('o', 'splitbelow', true)
utils.opt('o', 'splitright', true)
utils.opt('w', 'number', true)
utils.opt('w', 'relativenumber', true)
utils.opt('o', 'updatetime', 300)
utils.opt('o', 'mouse', '')
-- utils.opt('o', 'clipboard','unnamedplus')


--utils.map('n', '<leader>q', '<cmd>CHADopen<CR>')
utils.map('n', '<leader>q', '<cmd>NvimTreeToggle<CR>')
utils.map('n', '<leader>t', '<cmd>vsplit | :terminal<CR>')
utils.map('n', '<C-p>', '<cmd>Telescope find_files<CR>')
utils.map('n', '<leader>p', '<cmd>Telescope find_files find_command=rg,--no-ignore-vcs,--hidden,--files<CR>')
utils.map('n', '<C-f>', '<cmd>Telescope live_grep<CR>')
utils.map('n', '<C-i>', '<cmd>lua vim.lsp.buf.formatting()<CR>')
utils.map('n', '<leader>1', '1gt')
utils.map('n', '<leader>2', '2gt')
utils.map('n', '<leader>3', '3gt')
utils.map('n', '<leader>4', '4gt')
utils.map('n', '<leader>5', '5gt')
utils.map('n', '<leader>6', '6gt')
utils.map('n', '<leader>7', '7gt')
utils.map('n', '<leader>8', '8gt')
utils.map('n', '<leader>9', '9gt')
utils.map('n', '<leader>g', '<cmd>vertical Git<CR>')
--utils.map('t', '<Esc>', '<C-\\><C-n>')
utils.map('n', '<F5>', "<cmd>lua require'dap'.continue()<CR>")
utils.map('n', '<F10>', "<cmd>lua require'dap'.step_over()<CR>")
utils.map('n', '<F8>', "<cmd>lua require'dap'.step_into()<CR>")
utils.map('n', '<F12>', "<cmd>lua require'dap'.step_out()<CR>")
utils.map('n', '<leader>b', "<cmd>lua require'dap'.toggle_breakpoint()<CR>")
utils.map('n', '<leader>i', "<cmd>lua inspectcursor()<CR>")
utils.map('n', '<leader>d', "<cmd>lua require'dapui'.toggle()<CR>")
utils.map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
utils.map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
utils.map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
utils.map('n', '<leader>f', '<cmd>lua vim.lsp.buf.format { async = true }<CR>')

-- CHADTree
local chadtree_settings = { keymap = { tertiary = { "t" }, trash = { "T" } } }
vim.api.nvim_set_var("chadtree_settings", chadtree_settings)


-- autotag
require 'nvim-treesitter.configs'.setup {
    autotag = {
        enable = true,
    }
}

--vimsign
require('gitsigns').setup {
    signs                             = {
        add          = { hl = 'GitSignsAdd', text = '│', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
        change       = { hl = 'GitSignsChange', text = '│', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
        delete       = { hl = 'GitSignsDelete', text = '_', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
        topdelete    = { hl = 'GitSignsDelete', text = '‾', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
        changedelete = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
    },
    signcolumn                        = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl                             = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl                            = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff                         = false, -- Toggle with `:Gitsigns toggle_word_diff`
    keymaps                           = {
        -- Default keymap options
        noremap = true,

        ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'" },
        ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'" },

        ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
        ['v <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
        ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
        ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
        ['v <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
        ['n <leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
        ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
        ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
        ['n <leader>hS'] = '<cmd>lua require"gitsigns".stage_buffer()<CR>',
        ['n <leader>hU'] = '<cmd>lua require"gitsigns".reset_buffer_index()<CR>',

        -- Text objects
        ['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
        ['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>'
    },
    --watch_index = {
    --  interval = 1000,
    -- follow_files = true
    --},
    attach_to_untracked               = true,
    current_line_blame                = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts           = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
    },
    current_line_blame_formatter_opts = {
        relative_time = false
    },
    sign_priority                     = 6,
    update_debounce                   = 100,
    status_formatter                  = nil, -- Use default
    max_file_length                   = 40000,
    preview_config                    = {
        -- Options passed to nvim_open_win
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
    },
    --use_internal_diff = true,  -- If vim.diff or luajit is present

    yadm = {
        enable = false
    },
}
