call plug#begin('~/.vim/plugged')
"Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'scrooloose/nerdtree'
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
Plug 'tomasiser/vim-code-dark'
Plug 'gregsexton/MatchTag'
call plug#end()

filetype plugin indent on
" theme
colorscheme codedark 
" clipboard
set clipboard+=unnamedplus
" editor congig "
set number
set tabstop     =4
set softtabstop =4
set shiftwidth  =4
set expandtab
set number relativenumber
set nu rnu
"tab selection
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

" mapping "
let mapleader = ","
noremap <C-p> :Files<CR>
map <C-n> :tabnew<CR>
map <C-t> :tabnew<CR>
map <C-S-i> :Autoformat<CR>

tnoremap <Esc> <C-\><C-n>
" map nerdtree to the ctrl+n
function MyNerdToggle()
    if &filetype == 'nerdtree' || exists("g:NERDTree") && g:NERDTree.IsOpen()
        :NERDTreeToggle
    else
        :NERDTreeFind
    endif
endfunction

nnoremap <Leader>q :call MyNerdToggle()<CR>
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
