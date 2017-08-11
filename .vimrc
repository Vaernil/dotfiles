" TODO change inline comments to this terrible hack: just use | to separate,
" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'		" sensible defaults
Plug 'chrisbra/Colorizer'		" colorizes hex values, though incorrectly sometimes, to investigate
Plug 'scrooloose/nerdtree'
Plug 'Chiel92/vim-autoformat'
Plug 'gerw/vim-HiLinkTrace'		" :HLT! lets you track highlight groups
" themes and colors
Plug 'widatama/vim-phoenix' 
Plug 'w0ng/vim-hybrid'
Plug 'fcpg/vim-fahrenheit'
Plug 'nanotech/jellybeans.vim'
Plug 'junegunn/seoul256.vim'
Plug 'reedes/vim-colors-pencil'
Plug 'chriskempson/base16-vim'
Plug 'tomasiser/vim-code-dark'
" promptline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-surround'		" surround text easily
Plug 'tpope/vim-repeat'			" let's you repeat . not only native commands
Plug 'terryma/vim-multiple-cursors'	" sublime-like multiple cursors
Plug 'ntpeters/vim-better-whitespace'
"Plug 'edkolev/promptline.vim'
"Plug 'itchyny/lightline.vim'
"Plug 'cocopon/lightline-hybrid.vim'
call plug#end()
"################
set mouse=a						" mouse, I know, I know, it's mainly for scrolling, might reconsider 
set clipboard=unnamedplus		" global clipboard
set number						" show line numbers 
set autoindent noexpandtab tabstop=4 shiftwidth=4|	"tab 4 spaces
set hidden						" hides buffer instead of closing them, supposedly must have, will see 
set autoindent					" always set autoindenting on
set copyindent					" copy the previous indentation on autoindenting 
set showmatch					" set show matching parenthesis
set ignorecase					" ignore case when searching 
set smartcase					" ignore case if search pattern is all lowercase case-sensitive otherwise
set hlsearch					" highlight search terms 
set incsearch					" show search matches as you type
set title						" change the terminal's title 
set noerrorbells				" don't beep
set visualbell					" don't beep 
set cursorline					" highlight line number
set t_vb=						" disable last and first line flashing
set splitbelow					" more natural split behavior I guess
set splitright
set t_Co=256					" set 256 colors
" set t_Co=16					" will only use the colors in your xresources
syntax on						" activate syntax highlighting
let g:BASH_Ctrl_j = 'off'		" disable ctrl j, not sure if needed
" set termguicolors				" truecolor, but since urxvt doesnt support it, its moot
set background=dark
colorscheme fahrenheit
"colorscheme codedark
"colorscheme hybrid
"colorscheme base16-ocean
"colorscheme jellybeans
" airline overrides, colors hardcoded for now 
" theme overrides 
hi background ctermbg='none'
let g:airline_theme='jellybeans'
let g:airline_mode_map = {
\ '__' : '-',
\ 'n'  : 'N',
\ 'i'  : 'I',
\ 'R'  : 'R',
\ 'c'  : 'C',
\ 'v'  : 'V',
\ 'V'  : 'V',
\ '' : 'V',
\ 's'  : 'S',
\ 'S'  : 'S',
\ '' : 'S',
\ }
let g:airline#extensions#tabline#enabled = 1	" always have tabs
" NERDTree settings
let g:NERDTreeHighlightCursorline = 1			" higlight directory
let g:NERDTreeChDirMode = 2						" CWD is changed whenever the tree root is changed
let g:NERDTreeIgnore=['.git$[[dir]]', '\.serverauth\.[0-9]{3,}', '\~$']	" ignore list, REGEX
let g:NERDTreeMouseMode = 2						" single click opens directory, double - files
let g:NERDTreeShowHidden = 1					" display hidden files by default
let g:NERDTreeAutoDeleteBuffer = 1
"################
"#	KEYBINDS
"################
" leader as , instead of default \
let mapleader = ","
"show all groups
map <leader>hit :so $VIMRUNTIME/syntax/hitest.vim<cr>
nnoremap ; :
"clear highlight ,/
nmap <silent> <leader>/ :nohlsearch<CR>
" w!! sudos document if you forgot before
cmap w!! w !sudo tee % >/dev/null
" you can open your vimrc anwyehre by ,vimrc, then it automagically
" sources/refreshes it
map <leader>vimrc :tabe $MYVIMRC<cr>
autocmd bufwritepost .vimrc source $MYVIMRC
" Q for formatting the current paragraph (or selection)
"vmap Q gq
"nmap Q gqap
" Select all text CTRL + a
nmap <C-a> ggVG
" remap h to insert and use ijkl for inverse T cursor movement 
map i <Up>
map j <Left>
map k <Down>
noremap h i
" remap ik so so that it jumps to the next row in the editor
nnoremap k gj
nnoremap i gk
" remap popup navigation to ctrl i and k, for consistency
inoremap <expr> <C-i> pumvisible() ? "\<C-P>" : "\<C-i>"
inoremap <expr> <C-k> pumvisible() ? "\<C-N>" : "\<C-k>"
" remape ctrl f and b to pgup and pgdown
noremap <C-f> <C-b>
noremap <C-b> <C-f>
" remap Shift h to s i for mass commenting etc. and vice versa
noremap <S-h> <S-i>
noremap <S-i> <S-h>
noremap <S-k> <S-l>
noremap <S-l> <S-k>
noremap <C-h> <C-i>
" Ctrl + h acts as escape, because h is my insert, not gonna lie, kinda
" awkward
inoremap <C-h> <Esc>
" left switch window
nnoremap <C-j> <C-w>h
" up switch window
nnoremap <C-i> <C-w>k
" down switch window
nnoremap <C-k> <C-w>j
" right switch window
nnoremap <C-l> <C-w>l
" same remaps as above
nnoremap <C-w>j <C-w>h
nnoremap <C-w>i <C-w>k
nnoremap <C-w>k <C-w>i
"nnoremap <C-w>l <C-w>l
" right switch window sets alt key to charkey so the remap works
if !has('nvim')
	execute "set <M-l>=\el"
	execute "set <M-k>=\ek"
	execute "set <M-w>=\ew"
endif
" verical split
nnoremap <M-l> <C-w>v
" horizontal split
nnoremap <M-k> <C-w>s
" quit window 
nnoremap <M-w> <C-w>q
" equalize splits ,sp will show you what highlight group the text you have under cursor belongs
nnoremap <M-=> <C-w>=
" open nerdtree browsing
map <C-n> :NERDTreeToggle<CR>
" change key because i is up, dunno if it unmap its? or just changes to
" obscure \ key
let NERDTreeMapOpenSplit='\i'
" NERDTree automatically if vim is opened without arguments
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" close NERDTree if its the only window left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
""""""""""""""""""""""""""""
" Read-only .doc through antiword
autocmd BufReadPre *.doc silent set ro
autocmd BufReadPost *.doc silent %!antiword "%"
" Read-only odt/odp through odt2txt
autocmd BufReadPre *.odt,*.odp silent set ro
autocmd BufReadPost *.odt,*.odp silent %!odt2txt "%"
" Read-only pdf through pdftotext
autocmd BufReadPre *.pdf silent set ro
autocmd BufReadPost *.pdf silent %!pdftotext -nopgbrk -layout -q -eol unix "%" - | fmt -w78
" Read-only rtf through unrtf
autocmd BufReadPre *.rtf silent set ro
autocmd BufReadPost *.rtf silent %!unrtf --text
