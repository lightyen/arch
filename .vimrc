set encoding=utf-8
set history=3000
set ttimeoutlen=50

set autoindent
set tabstop=4
set shiftwidth=4
set softtabstop=-1
set noexpandtab
set hls

set numberwidth=4
set iskeyword+=-

syntax enable
syntax on

filetype off
set nocompatible
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'maxmellon/vim-jsx-pretty'
Plugin 'tpope/vim-commentary'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'joshdick/onedark.vim'
Plugin 'scrooloose/syntastic'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'prettier/vim-prettier', {
	\ 'do': 'yarn install',
	\ 'for': ['javascript']
	\ }
call vundle#end()
filetype plugin indent on

if &term == "alacritty"
	let &term = "xterm-256color"
endif

if (has("autocmd") && !has("gui_running"))
	augroup colorset
		autocmd!
		let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
		autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " `bg` will not be styled since there is no `bg` setting
	augroup END
endif

try
	colorscheme onedark
	if has("termguicolors")
		if v:version < 800
			set t_8b=^[[48;2;%lu;%lu;%lum
			set t_8f=^[[38;2;%lu;%lu;%lum
		endif

		" enable true color
		set termguicolors
	endif
catch /^Vim\%((\a\+)\)\=:E185/

endtry

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

if has("autochdir")
	set autochdir
endif

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
nnoremap <A-Up> :m .-2<CR>==
nnoremap <A-Down> :m+<CR>==
nnoremap <ESC>j :m+<CR>==
nnoremap <ESC>k :m .-2<CR>==
nnoremap <F2> :set nu!<CR>
nnoremap <F4> :set list!<CR>
nnoremap <F5> :set rnu!<CR>
nnoremap <F3> :set hlsearch!<CR>

" Output the current syntax group
nnoremap <f10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
	\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
	\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<cr>

let g:prettier#config#semi = 'false'
let g:prettier#config#single_quote = 'false'
let g:prettier#config#jsx_single_quote = 'false'
let g:prettier#config#arrow_parens = 'avoid'
let g:prettier#config#trailing_comma = 'all'

let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.json,*.graphql,*.md PrettierAsync

