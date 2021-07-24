set encoding=utf-8
set history=3000
set ttimeoutlen=50

set tabstop=4
set tabstop=4
set shiftwidth=4
set expandtab

set signcolumn=yes
syntax enable
syntax on
set hls
set termguicolors

filetype off
set nocompatible
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'maxmellon/vim-jsx-pretty'
Plugin 'prettier/vim-prettier', { 'do': 'yarn install', 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
Plugin 'scrooloose/nerdtree'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-commentary'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'joshdick/onedark.vim'
call vundle#end()
filetype plugin indent on

if &term == "alacritty"
  let &term = "xterm-256color"
endif

let g:powerline_pycmd = 'py3'

" itchyny/lightline settings
set laststatus=2

let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ }

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

colorscheme onedark


set numberwidth=4
set runtimepath+=$HOME/.vim/plugins/vim-gitgutter
let g:gitgutter_async = 0
let g:gitgutter_enabled = 0
set autochdir
let NERDTreeChDirMode=2
au VimEnter NERD_tree_1 enew | execute 'NERDTree '.argv()[0]


" NERDTree
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }


" YouCompleteMe
let g:ycm_use_clangd = 0

" Prettier
let g:prettier#autoformat = 1

highlight LineNr guifg=#BD93F9 guibg=#303030

set listchars=tab:→\ ,space:\ ,extends:⟩,precedes:⟨
set list

set noerrorbells             " No beeps
set number                   " Show line numbers
set noswapfile               " Don't use swapfile
set showcmd                  " Show me what I'm typing
set nobackup                 " Don't create annoying backup files
set splitright               " Split vertical windows right to the current windows
set splitbelow               " Split horizontal windows below to the current windows
set autowrite                " Automatically save before :next, :make etc.
set hidden
set fileformats=unix,dos,mac " Prefer Unix over Windows over OS 9 formats
set noshowmatch              " Do not show matching brackets by flickering
set noshowmode               " We show the mode with airline or lightline
set ignorecase               " Search case insensitive...
set smartcase                " ... but not it begins with upper case
set completeopt=menu,menuone
set nocursorcolumn           " speed up syntax highlighting
set cursorline               " show the focus line
set updatetime=500
set pumheight=10             " Completion window max size
set conceallevel=2           " Concealed text is completely hidden
set nowrap
set autoread
set clipboard=unnamedplus

" Keyboard mapping
nnoremap <C-c> "+yy
nnoremap <C-v> "+p
nnoremap <A-Down> :m+<CR>==
nnoremap <A-Up> :m .-2<CR>==
nnoremap <ESC>j :m+<CR>==
nnoremap <ESC>k :m .-2<CR>==
nnoremap <F2> :set nu!<CR>
nnoremap <F4> :set list!<CR>
nnoremap <F5> :set rnu!<CR>
nnoremap <F3> :set hlsearch!<CR>
nnoremap <F9> :NERDTreeToggle<CR>
nnoremap <leader>n :NERDTree .<CR>

" Output the current syntax group
nnoremap <f10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<cr>

