set nocompatible		" be iMproved, required
filetype off			" required

" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" Alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" Let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" Plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'Chiel92/vim-autoformat'
Plugin 'scrooloose/nerdtree'			" NERDTree
Plugin 'Xuyuanp/nerdtree-git-plugin'	" NERDTree git
Plugin 'scrooloose/nerdcommenter'		" commenter: \cc \cu
"Plugin 'Valloric/YouCompleteMe'		" Need version after 7.4
Plugin 'fholgado/minibufexpl.vim'

" Plugins for ctags
Plugin 'taglist.vim'
"Plugin 'majutsushi/tagbar'				" Need version after 7.3.1058 due to a bug in vim

Plugin 'vim-airline/vim-airline'		"https://github.com/vim-airline/vim-airline-themes
Plugin 'vim-airline/vim-airline-themes'

" Plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'

" Git plugin not hosted on GitHub
Plugin 'Command-T'
Plugin 'https://github.com/Raimondi/delimitMate'

" Git repos on local machine (working on my own plugin)
" Plugin 'file:///home/atmark/myplugin'
"
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

" Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()			" required

" Configuation for delimitMate, detail information: https://github.com/Raimondi/delimitMate
let delimitMate_expand_cr=1

filetype plugin indent on	" required
" To ignore plugin indent changes, instead use:
"filetype plugin on

set nu
set tabstop=4
set softtabstop=4
set showcmd
set showmode
set nowrap
set shiftwidth=4
set showmatch
set autowrite
set history=500
set ruler
set clipboard=unnamed
set list
set listchars=tab:--
set t_Co=256
syntax enable

colorscheme torte

set mouse=a
set path=.,,**

" Backspace
set backspace=indent,eol,start

" Enable folding
set foldmethod=indent
set foldlevel=99

" Cursor
set cursorline
set cursorcolumn
hi CursorLine cterm=none ctermbg=DarkMagenta ctermfg=White
hi CursorColumn cterm=none ctermbg=DarkMagenta ctermfg=White

" Search
set hlsearch
set incsearch
hi Search cterm=reverse ctermbg=none ctermfg=none

" Indent
"set autoindent
"set smartindent
set cindent

" Status bar
set laststatus=2

" Configuration of vim-airline
let g:airline_theme='deus'
"let g:airline_theme='jellybeans'

" Disable statusline becasue using vim-airline
"set statusline=[%{expand('%:p')}][%{strlen(&fenc)?&fenc:&enc},\ %{&ff},\ %{strlen(&filetype)?&filetype:'plain'}]%{FileSize()}%{IsBinary()}%=%c,%l/%L\ [%3p%%]
"set statusline=%#filepath#[%{expand('%:p')}]%#filetype#[%{strlen(&fenc)?&fenc:&enc},\ %{&ff},\ %{strlen(&filetype)?&filetype:'plain'}]%#filesize#%{FileSize()}%{IsBinary()}%=%#position#%c,%l/%L\ [%3p%%]

" Configuration for the color of statusline
highlight filepath cterm=none ctermbg=238 ctermfg=40
highlight filetype cterm=none ctermbg=238 ctermfg=45
highlight filesize cterm=none ctermbg=238 ctermfg=225
highlight position cterm=none ctermbg=238 ctermfg=228

" Configuration for the content of statusline
function IsBinary()
	if (&binary == 0)
		return ""
	else
		return "[Binary]"
	endif
endfunction

function FileSize()
	let bytes=getfsize(expand("%:p"))
	if bytes <= 0
		return "[Empty]"
	endif
	if bytes < 1024
		return "[" . bytes . "B]"
	elseif bytes < 1048576
		return "[" . (bytes / 1024) . "KB]"
	else
		return "[" . (bytes / 1048576) . "MB]"
	endif
endfunction
" End of status bar

" File encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

" Setting for gvim
if has("unix")
	let s:uname = system("uname -s")
	if s:uname == "Darwin"
		" Do Mac stuff here
		echo 'Mac'
	endif
elseif has("win32")
	if $LANG == 'ja' " Set menu language in ja environment
		source delmenu.vim
		language messages $VIMRUNTIME\ja_jp.utf-8
	endif
endif

if has("gui_running")
	" GUI is running or is about to start.
	" Maximize gvim window (for an alternative on Windows, see simalt below).
	set lines=999 columns=999
endif

" Convert file encoding to utf-8
map <C-U> :call ToUTF8()<CR>
map! <C-U> <Esc>:call ToUTF8()<CR>
function ToUTF8()
	if (&fileencoding == "utf-8")
		echo "It is already UTF-8."
	else
		echo "Convert to UTF-8."
		let &fileencoding="utf-8"
	endif
	let &ff="unix"
endfunction

" Convert tabe to space
"map <C-t> :call TabToSpaces()<CR>
"map! <C-t> <Esc>:call TabToSpaces()<CR>
"function TabToSpaces()
""	retab
"	echo "Convert tab to spaces."
"endfunction

nnoremap <F2> :set nonumber!<CR>
nnoremap <F3> :Autoformat<CR>

" Tab related setting
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
nnoremap <slient> <A-Left> :execute 'slient! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <slient> <A-Right> :execute 'slient! tabmove ' . (tabpagenr()+1)<CR>

" Buffer related setting
nnoremap <F4> :buffers<CR>:buffer<Space>

" Split related setting
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Switch between simple mode and full mdoe
map <C-F7> :call SwitchFullSimpleMode()<CR>
map! <C-F7> <Esc>:call SwitchFullSimpleMode()<CR>
function SwitchFullSimpleMode()
	if (&mouse == "a")
		let &mouse = ""
		set nocindent
		set nonumber
		set wrap
		echo "Switch to simple mode.(nomouse, nonumber, nocindent, wrap)"
	else
		let &mouse = "a"
		set cindent
		set number
		set nowrap
		echo "Switch to full mode.(mouse, number, cindent, nowrap)"
	endif
endfunction

" Configuration of NERDTree
" Ctrl+N Open/Close
map <C-n> :NERDTreeToggle<CR>
" Open if Vim start without any files
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Close when all files are closed
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" Do not show those files
let NERDTreeIgnore=['\.pyc$', '\~$', 'node_modules']	" Ignore files in NERDTree
" Do not show additional information on NERDTree, e.g. help, hint.
let NERDTreeMinimalUI=1
let NERDTreeWinPos='left'
let NERDTreeWinSize=30

" Configuration of MiniBufExplorer
" F5 and F6 to switch between buffer
let g:miniBufExplMapWindowNavVim=1   
let g:miniBufExplMapWindowNavArrows=1   
let g:miniBufExplMapCTabSwitchBufs=1   
let g:miniBufExplModSelTarget=1  
let g:miniBufExplMoreThanOne=0

map <F5> :MBEbp<CR>
map <F6> :MBEbn<CR>
map <A-Left> :MBEbp<CR>
map <A-Right> :MBEbn<CR>


" Need version after 7.3.1058 due to a bug in vim
" Configuration of tagbar
" F8 Open/Close
"nmap <F8> :TagbarToggle<CR>
"let g:tagbar_autofocus=1			" Automatically focus when start
"let g:tagbar_ctags_bin='ctags'		" Binary file name of ctags
"let g:tagbar_width=30				" Width of tagbar
"autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen() " If the surfix matched, automatically open tagbar

" Configuration of Taglist
" F9 Open/Close
map <F9> :Tlist<CR>
let Tlist_Ctags_Cmd='ctags'
let Tlist_Auto_Open=1
let Tlist_Show_One_File=1		" Only show tag for current file
let Tlist_WinWidt=28			" Width of taglist
let Tlist_Exit_OnlyWindow=1		" Close vim if taglist if final window
let Tlist_Use_Right_Window=1	" Show taglist window on the rigth side
"let Tlist_Use_Left_Window=1	" Show taglist window at the left side

" Configuration for cscope
set cscopequickfix=s-,c-,d-,i-,t-,e-
if has("cscope")
	set csprg=/usr/bin/cscope
	set csto=0
	set cst
	set nocsverb
	" add any database in current directory
	if filereadable("cscope.out")
		cs add cscope.out
	" else add database pointed to by environment
	elseif $CSCOPE_DB != ""
		cs add $CSCOPE_DB
	endif
	set csverb
endif
nmap <C-Space>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-Space>i :cs find i <C-R>=expand("<cfile>")<CR><CR>
nmap <C-Space>d :cs find d <C-R>=expand("<cword>")<CR><CR>

