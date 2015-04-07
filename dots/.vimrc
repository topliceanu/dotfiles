" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" ================ General Config ====================

set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set autoread                    "Reload files changed outside vim

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

"turn on syntax highlighting
syntax on

" Change leader to a comma because the backslash is too far away
" That means all \x commands turn into ,x
" The mapleader has to be set before vundle starts loading all
" the plugins.
let mapleader=","

" ==================== Vundle =======================

filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

" =============== Vundle Bundles ====================

" Language support.
Bundle "pangloss/vim-javascript"
Bundle "kchmck/vim-coffee-script"
Bundle "groenewege/vim-less"
Bundle "mxw/vim-jsx"
Bundle "mattn/emmet-vim.git"

" Improve navigation.
Bundle 'kien/ctrlp.vim'
Bundle "scrooloose/nerdtree.git"

" Syntax highlight.
Bundle "scrooloose/syntastic.git"

" Automatic Tab Completion.
Bundle "ervandew/supertab"

" Sexy Status Bar
Bundle 'bling/vim-airline'

filetype plugin indent on

" ================ Mappings =========================

map <F2> :NERDTreeToggle %:p:h<CR>

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb
set nowritebackup

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.

silent !mkdir ~/.vim/backups > /dev/null 2>&1
set undodir=~/.vim/backups
set undofile

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set ts=4
set sw=4

filetype plugin on
filetype indent on

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" ==================== GVim GUI =====================

set guioptions-=T       "remove toolbar
set guioptions-=m
set guioptions-=r
set guioptions-=L       "remove scrollbar
set colorcolumn=80      "highlight the 80th character column
set cursorline          "highlight line on cursor

" =================== Search ========================

set ignorecase          "case-insensitive search
set smartcase
set hlsearch            "hightlight search results
set incsearch           "continuously refine search

" ====================== Colors =====================

set t_Co=256 " Set 256 color terminal.
if has('gui_running')
    colorscheme wombat
else
    colorscheme wombat256mod
endif

"========= Trailing white spaces ==========

" Highlight trailing whitespace.
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
" Automatically remove trainling white space on save.
autocmd BufWritePre * :%s/\s\+$//e

" ================ Completion =======================

set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

" ================ Scrolling ========================
set sidescrolloff=15
set sidescroll=1

" =================== Tabs ==========================

" Add tab navigation shortcuts
" CTRL+left, CTRL+right switches between tabs.
" ALT+left, ALT+right moves tabs to left/right.
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>

" Setup the line endings for the unix operating system.
set ff=unix

" ================= Ctrlp ===========================
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]node_modules$',
  \ }

" ================= NERDTree ========================
let NERDTreeIgnore = ['\.pyc$']
