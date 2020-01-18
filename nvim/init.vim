let mapleader = ","

call plug#begin('~/.local/shard/vim/plugged')

Plug 'scrooloose/nerdTree'
Plug 'tomasiser/vim-code-dark'
Plug 'tpope/vim-fugitive'
Plug 'cespare/vim-toml'
Plug 'sheerun/vim-polyglot'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

call plug#end()

" Configuration
set autoread  " automatically read files changed outside of vim.
set visualbell  " Use a visual bell instead of beeping.

set scrolloff=3  " Scroll 3 lines from the edge.
set hlsearch  " Highlight search terms.
set incsearch  " Incremental search.

set showmatch  " Show matching brackets.
set matchtime=3  " How long to blick matching brackets for (1/10 of sec).

set backspace=indent,eol,start  " Allow backspacing over everything.

set directory=$HOME/tmp  " Use a temporary directory for swp files.

set termguicolors

colorscheme codedark

syntax on  " Turn on syntax highlighting.
syntax enable
syntax sync fromstart  " Determine syntax highlighting from start of file.
set number  " Show line numbers.
set lz  " Laxy redraw of macros.

" Status Bar
set laststatus=2

" Indent
set tabstop=4
set shiftwidth=4
set expandtab

" Keymaps

nmap <Leader>n :NERDTreeToggle<cr>
nmap <Leader>v :vsplit<cr>
nmap <Leader>s :split<cr>

" File types
filetype on
filetype plugin on
filetype indent on

set cc=101  " Highlight the 101 column.

let g:python3_host_prog = '~/.pyenv/versions/neovim-3.8.1/bin/python'
let g:deoplete#enable_at_startup = 1


" Status line
hi StatColor guibg=#95e454 guifg=black ctermbg=lightgreen ctermfg=black
hi Modified guibg=orange guifg=black ctermbg=lightred ctermfg=black

function! MyStatusLine(mode)
    let statusline=""
    if a:mode == 'Enter'
        let statusline .= "%#StatColor#"
    endif

    let statusline .= "%f\ \(%n\)\ "
    if a:mode == 'Enter'
        let statusline .= "%*"
    endif

    let statusline .= "%#Modified#%m"
    if a:mode == 'Leave'
        let statusline .= "%*%r"
    elseif a:mode == 'Enter'
        let statusline .= "%r%*"
    endif

    let statusline .= "\ (%l/%L,%P)\ %=%h%2\ [\%03.3b,0x\%02.2B]%y[%{&fileformat}]%{fugitive#statusline()}\ "
    return statusline
endfunction

au WinEnter * setlocal statusline=%!MyStatusLine('Enter')
au WinLeave * setlocal statusline=%!MyStatusLine('Leave')

set statusline=%!MyStatusLine('Enter')

function! InsertStatuslineColor(mode)
    if a:mode == 'i'
        hi StatColor guibg=orange ctermbg=lightred
    elseif a:mode == 'r'
        hi StatColor guibg="#e454ba ctermbg=magenta
    elseif a:mode == 'v'
        hi StatColor guibg="#e454ba ctermbg=magenta
    else
        hi StatColor guibg=red ctermbg=red
    endif
endfunction

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi StatColor guibg=#95e454 guifg=black ctermbg=lightgreen ctermfg=black


" Update buffer on external file changes
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
autocmd FileChangedShellPost *
            \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

autocmd VimResized * wincmd = " Resize splits when vim is resized
autocmd BufWritePre * %s/\s\+$//e " remove trailing whitespace on save

set t_ut= " Disable Background Color Erase (BCE) so that color schemes work propery inside tmux
