set nocompatible              " be iMproved, required
filetype off                  " required


" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundleshould install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}


Plugin 'suan/vim-instant-markdown', {'rtp': 'after'}	" MD preview
Plugin 'itchyny/lightline.vim'				" Statusbar
Plugin 'joshdick/onedark.vim'				" One Dark
Plugin 'gko/vim-coloresque' 				" CSS colors
Plugin 'chrisbra/csv.vim'				" View CSV files nicely
Plugin 'scrooloose/nerdtree'				" File Explorer
Plugin 'Xuyuanp/nerdtree-git-plugin'			" Show github status flags in Nerdtree
Plugin 'mhinz/vim-startify'				" vim start screen
Plugin 'neoclide/coc.nvim'				" Autocompletion
Plugin 'preservim/nerdcommenter'			" Commenting

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
set laststatus=2  " always display the status line
set background=dark
syntax on
colorscheme onedark

function! CocCurrentFunction()
	return get(b:, 'coc_current_function', '')
endfunction

let g:lightline = {
	\ 'colorscheme': 'one',
	\ 'active': {
	\	'left': [ [ 'mode', 'paste' ],
	\		  [ 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ]
	\
	\ },
	\ 'component_function': {
	\	'cocstatus': 'coc#status',
	\	'currentfunction': 'CocCurrentFunction'
	\ },
	\ }

set nu
set shortmess=F
set noshowmode
set mouse=a
command! -nargs=0 Prettier :CocCommand prettier.formatFile
