
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

-- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
--  if client.resolved_capabilities.document_formatting then
    --    buf_set_keymap("n", "<C-i>", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
--  elseif client.resolved_capabilities.document_range_formatting then
--    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
--  end
  if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec(
        [[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=#464646
      hi LspReferenceText cterm=bold ctermbg=red guibg=#464646
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=#464646
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
        false)
  end
--if client.resolved_capabilities.document_highlight then
--      vim.api.nvim_exec(
--      [[
--      hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
--      hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
--      hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
--      augroup lsp_document_highlight
--      autocmd! * <buffer>
--      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
--      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
--      augroup END
--      ]],
--      false)
--end
end
-- replace the default lsp diagnostic letters with prettier symbols
 vim.fn.sign_define("LspDiagnosticsSignError", {text = "", numhl = "LspDiagnosticsDefaultError"})
 vim.fn.sign_define("LspDiagnosticsSignWarning", {text = "", numhl = "LspDiagnosticsDefaultWarning"})
 vim.fn.sign_define("LspDiagnosticsSignInformation", {text = "", numhl = "LspDiagnosticsDefaultInformation"})
 vim.fn.sign_define("LspDiagnosticsSignHint", {text = "", numhl = "LspDiagnosticsDefaultHint"})

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- LSP Saga config & keys https://github.com/glepnir/lspsaga.nvim
local capabilities = vim.lsp.protocol.make_client_capabilities()
--capabilities.textDocument.completion.completionItem.snippetSupport = true
--capabilities.textDocument.completion.completionItem.resolveSupport = {
--  properties = {
--    "documentation",
--    "detail",
--    "additionalTextEdits",
--  },
--}

--local saga = require("lspsaga")
--saga.init_lsp_saga({
--  code_action_icon = " ",
--  definition_preview_icon = "  ",
--  dianostic_header_icon = "   ",
--  error_sign = " ",
--  finder_definition_icon = "  ",
--  finder_reference_icon = "  ",
--  hint_sign = "⚡",
--  infor_sign = "",
--  warn_sign = "",
--})

--vim.lsp.diagnostic.show_line_diagnostics()
--vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
--  virtual_text = false,
--})

require'lspconfig'.pyright.setup{
    on_attach = on_attach,
    capabilities = capabilities
--    root_dir = util.root_pattern(".git", "setup.py",  "setup.cfg", "pyproject.toml", "requirements.txt");
}
require'lspconfig'.intelephense.setup{}
require'lspconfig'.tsserver.setup{}
require'lspconfig'.html.setup{
    cmd = { "html-languageserver", "--stdio" },
    filetypes = { "html" },
    init_options = {
      configurationSection = { "html", "css", "javascript" },
      embeddedLanguages = {
        css = true,
        javascript = true
      }
    },
    settings = {}
}

--map("n", "<Leader>cf", ":Lspsaga lsp_finder<CR>", { silent = true })
--map("n", "<leader>ca", ":Lspsaga code_action<CR>", { silent = true })
--map("v", "<leader>ca", ":<C-U>Lspsaga range_code_action<CR>", { silent = true })
--map("n", "<leader>ch", ":Lspsaga hover_doc<CR>", { silent = true })
--map("n", "<leader>ck", '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(-1)<CR>', { silent = true })
--map("n", "<leader>cj", '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(1)<CR>', { silent = true })
--map("n", "<leader>cs", ":Lspsaga signature_help<CR>", { silent = true })
--map("n", "<leader>ci", ":Lspsaga show_line_diagnostics<CR>", { silent = true })
--map("n", "<leader>cn", ":Lspsaga diagnostic_jump_next<CR>", { silent = true })
--map("n", "<leader>cp", ":Lspsaga diagnostic_jump_prev<CR>", { silent = true })
--map("n", "<leader>cr", ":Lspsaga rename<CR>", { silent = true })
--map("n", "<leader>cd", ":Lspsaga preview_definition<CR>", { silent = true })
map("n", "<leader>f", ":Format<CR>", { silent = true })
-- Hop
--require("hop").setup()
--map("n", "<leader>h", ":HopWord<CR>")
--map("n", "<leader>l", "<cmd>lua require'hop'.hint_lines()<cr>")
--map("v", "<leader>h", "<cmd>lua require'hop'.hint_char2()<cr>")
--map("v", "<leader>l", "<cmd>lua require'hop'.hint_lines()<cr>")
