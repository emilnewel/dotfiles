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
Plugin 'chrisbra/csv.vim'				" View CSV files nicely
Plugin 'scrooloose/nerdtree'				" File Explorer
Plugin 'arcticicestudio/nord-vim'			"nord-vim colorscheme
Plugin 'Xuyuanp/nerdtree-git-plugin'			" Show github status flags in Nerdtree
Plugin 'mhinz/vim-startify'				" vim start screen
Plugin 'neoclide/coc.nvim', {'branch': 'relase'}	" Autocompletion
Plugin 'preservim/nerdcommenter'			" Commenting
Plugin 'ryanoasis/vim-devicons'				" Nerdtree file icons
Plugin 'pangloss/vim-javascript'			" JS syntax hightlight
Plugin 'peitalin/vim-jsx-typescript'			" JSX/TSX syntax highlight
Plugin 'leafgarland/typescript-vim'			" TS syntax highlight
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'	" Colors for fileicons
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }	" Searching
Plugin 'junegunn/fzf.vim'															" Searching


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

" ------------ VIM layout ---------------
colorscheme nord
set laststatus=2  " always display the status line
set background=dark
syntax on

if !has('gui_running')
	  set t_Co=256
endif

if (has("termguicolors"))
  set termguicolors
endif
" ---------------------------------------
"
function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

let g:lightline = {
	\ 'colorscheme': 'nord',
  \ 'active': {
  \	'left': [ [ 'mode', 'paste' ],
  \		  [ 'fugitive' ], 
	\			['filename'] 
	\	],
	\ 'right': [ ['lineinfo'], ['percent'] ]
  \
  \ },
  \ 'component_function': {
		\ 'fugitive': 'LightlineFugitive',
		\	'filename': 'LightlineFilename',
		\ 'filetype': 'MyFiletype',
		\	'cocstatus': 'coc#status',
		\	'currentfunction': 'CocCurrentFunction',
		\ 'gitbranch': 'FugitiveHead'
  \ },
	\ 'separator': { 'left': '', 'right': '' },
	\ 'subseparator': { 'left': '', 'right': '' },
  \ }


function! MyFiletype()
	return winwidth(0) > 70 ? (strlen(&filetype) ? WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! LightlineFilename()
	 let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
	 let filetype = MyFiletype()
	 return filename . ' - ' . filetype
endfunction

" Function for showing git branch in lightline with fugitive.

function! LightlineFugitive()
  if &filetype ==# 'help'
		return ''
	endif

	if has_key(b:, 'lightline_fugitive') && reltimestr(reltime(b:lightline_fugitive_)) =~# '^\s*0\.[0-5]'
		return b:lightline_fugitive
	endif

	try
		if exists('*fugitive#head')
			let head = fugitive#head()
		else
			return ''
		endif
		
		let b:lightline_fugitive = head
		let b:lightline_fugitive_ = reltime()
		
		return b:lightline_fugitive
	catch
	endtry
	
	return ''
endfunction

" after a re-source, fix syntax matching issues (concealing brackets):
if exists('g:loaded_webdevicons')
	    call webdevicons#refresh()
endif

let g:webdevicons_conceal_nerdtree_brackets=1

set cursorline
set nu
set shortmess=F
set noshowmode
set mouse=a
set encoding=UTF-8


set ignorecase		" Case insensitive search
set smartcase		" Case sensitive if capital letters
set ts=2 sw=2		" Set tab to 2 spaces

nmap <C-n><C-t> :NERDTreeToggle<CR>
nmap <C-Right> :vertical res +1<CR>
nmap <C-Left> :vertical res -1<CR>
nmap <C-Up> :res +1<CR>
nmap <C-Down> :res -1<CR>

" ---------------------- FZF Mapping ------------
map <C-F> <Esc><Esc>:Files!<CR>     			" Find in current dir (Normal mode)
map / <Esc><Esc>:BLines!<Cr>							" Find in current file (Insert mode)
map <C-G> <Esc><Esc>:GFiles?<Cr> 					" Look through changed git files



command! -nargs=0 Prettier :CocCommand prettier.formatFile


