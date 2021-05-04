call plug#begin('~/.vim/plugged')
" Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'scrooloose/nerdtree'


Plug 'elmar-hinz/vim.typoscript'
Plug 'Xuyuanp/nerdtree-git-plugin'
" Ctrl p open file "
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" line with gitbranch "
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'Chiel92/vim-autoformat'
Plug 'tpope/vim-surround'
Plug 'christoomey/vim-system-copy'
"Plug 'tomasiser/vim-code-dark'
Plug 'morhetz/gruvbox'
"Plug 'tomasr/molokai'
"Plug 'sonph/onehalf'
Plug 'gregsexton/MatchTag'
Plug 'mattn/emmet-vim'
" Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-vdebug/vdebug'
Plug 'honza/vim-snippets'
call plug#end()
" ident and format
filetype plugin on
filetype plugin indent on
let g:python3_host_prog='/usr/bin/python3'
" theme
" colorscheme codedark
"colorscheme molokai
 autocmd vimenter * colorscheme gruvbox
" clipboard needs wl-clipboard
"set clipboard+=unnamedplus
" editor congig "
set number
set tabstop     =4
set softtabstop =4
set shiftwidth  =4
set expandtab
let g:formatdef_html = '"html-beautify -p -f - --indent-inner-html
            \ --unformatted= --indent-size=".&shiftwidth'

set number relativenumber
"set nu rnu

" mapping "
let mapleader = ","
noremap <C-p> :Files<CR>
map <C-n> :tabnew<CR>
map <C-t> :tabnew<CR>
map <C-S-i> :Autoformat<CR>
nmap <F12> :set invnumber<CR>

tnoremap <Esc> <C-\><C-n>
"tab selection
" Switch between tabs
nnoremap <Leader>1 1gt
nnoremap <Leader>2 2gt
nnoremap <Leader>3 3gt
nnoremap <Leader>4 4gt
nnoremap <Leader>5 5gt
nnoremap <Leader>6 6gt
nnoremap <Leader>7 7gt
nnoremap <Leader>8 8gt
nnoremap <Leader>9 9gt


let NERDTreeQuitOnOpen=1
let g:NERDTreeWinSize=60
" map nerdtree to the ctrl+n
function MyNerdToggle()
    if &filetype == 'nerdtree' || exists("g:NERDTree") && g:NERDTree.IsOpen()
        :NERDTreeToggle
    else
        :NERDTreeFind
    endif
endfunction

nnoremap <Leader>q :call MyNerdToggle()<CR>
nnoremap <Leader>g :vertical Git<CR>
" nnoremap <leader>f :NERDTreeFind<CR>


"lightline"
let g:lightline = {
            \ 'colorscheme': 'wombat',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
            \ },
            \ 'component_function': {
            \   'gitbranch': 'FugitiveHead'
            \ },
            \ }


" With this function you can reuse the same terminal in neovim.
" You can toggle the terminal and also send a command to the same terminal.

let s:monkey_terminal_window = -1
let s:monkey_terminal_buffer = -1
let s:monkey_terminal_job_id = -1

function! MonkeyTerminalOpen()
    " Check if buffer exists, if not create a window and a buffer
    if !bufexists(s:monkey_terminal_buffer)
        " Creates a window call monkey_terminal
        new monkey_terminal
        " Moves to the window the right the current one
        wincmd J
        let s:monkey_terminal_job_id = termopen($SHELL, { 'detach': 1 })

        " Change the name of the buffer to "Terminal 1"
        silent file Terminal\ 1
        " Gets the id of the terminal window
        let s:monkey_terminal_window = win_getid()
        let s:monkey_terminal_buffer = bufnr('%')

        " The buffer of the terminal won't appear in the list of the buffers
        " when calling :buffers command
        set nobuflisted
    else
        if !win_gotoid(s:monkey_terminal_window)
            sp
            " Moves to the window below the current one
            wincmd J
            buffer Terminal\ 1
            " Gets the id of the terminal window
            let s:monkey_terminal_window = win_getid()
        endif
    endif
endfunction

function! MonkeyTerminalToggle()
    if win_gotoid(s:monkey_terminal_window)
        call MonkeyTerminalClose()
    else
        call MonkeyTerminalOpen()
    endif
endfunction

function! MonkeyTerminalClose()
    if win_gotoid(s:monkey_terminal_window)
        " close the current window
        hide
    endif
endfunction

function! MonkeyTerminalExec(cmd)
    if !win_gotoid(s:monkey_terminal_window)
        call MonkeyTerminalOpen()
    endif

    " clear current input
    call jobsend(s:monkey_terminal_job_id, "clear\n")

    " run cmd
    call jobsend(s:monkey_terminal_job_id, a:cmd . "\n")
    normal! G
    wincmd p
endfunction

" With this maps you can now toggle the terminal
nnoremap <Leader>t :call MonkeyTerminalToggle()<cr>


" coc
let g:coc_global_extensions = ['coc-phpls', 'coc-python', 'coc-snippets']
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" Use <c-space> to trigger completion.
if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif


" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

nnoremap <silent> <Leader>? :call fzf#run({ 'source': 'cat ~/.config/nvim/cheatsheet.txt', 'sink': 'e', 'options': '-m', 'down': '50%'})<CR>

" Allows Vdebug to bind to all interfaces.
let g:vdebug_options = {}

" Stops execution at the first line.
let g:vdebug_options['break_on_open'] = 1
let g:vdebug_options['max_children'] = 128

" Use the compact window layout.
let g:vdebug_options['watch_window_style'] = 'compact'

" Because it's the company default.
let g:vdebug_options['ide_key'] = 'PHPSTORM'


" Need to set as empty for this to work with Vagrant boxes.
let g:vdebug_options['server'] = ""
let g:vdebug_options['path_maps'] = {
      \  '/var/www/' : '/home/souellet/www/oqlf-vitrine-linguistique/',
      \  '/var/www/public' : '/home/souellet/www/oqlf-vitrine-linguistique/public',
      \  '/var/www/public/typo3conf/ext/tm_gdt' : '/home/souellet/www/oqlf-vitrine-linguistique/packages/tm_gdt',
      \}

set diffopt+=vertical

