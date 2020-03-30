"===========
" gx opens with default open
" TODO Read https://github.com/romainl/idiomatic-vimrc
" sort option via help options
" fix indent
" https://gist.github.com/mattratleph/4026987
"===========
" █▓▒░ INIT ░▒▓█
" INIT & PATHS {{{
	" init files and paths
	if has('nvim')
		" with this line, neovim will not read configurations from
		" $XDG_CONFIG_HOME/nvim/init.vim
		set runtimepath^=$XDG_CONFIG_HOME/vim runtimepath+=$XDG_CONFIG_HOME/vim/after
		let &packpath = &runtimepath
	else
		" classic vim config
		set viminfo+=$XDG_CACHE_HOME/vim/viminfo
		set runtimepath=$XDG_CONFIG_HOME/vim,$XDG_CONFIG_HOME/vim/after,$VIM,$VIMRUNTIME
		let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc"
	endif
" }}}

"******************************************************************************
"*************** BASIC CONFIG
"******************************************************************************
"  Behaviour Modification {{{
	" basic
	" encoding
	set encoding=utf-8 fileencoding=utf-8
	set fileencodings=ucs-bom,utf-8,latin2
	set fileformats=unix,dos,mac
	set clipboard=unnamedplus               " global clipboard
	" activate it via keybind
	" tab, indentation
	filetype plugin indent on
	set tabstop=4                      " Replace existing tab with 4 spaces width
	set softtabstop=4                  " Number of spaces during insert mode
	set shiftwidth=4                   " When indenting with '>', use 4 spaces width
	set noexpandtab                    " On pressing tab=tab, expandtab is opposite
	set shiftround                     " Shifting using `>` / `<` will be rounded off.
	" ie. when i am at 3 spaces, hitting `>>` will bring to 4 spaces instead of 3+`shiftwidth` spaces
	set autoindent                     " always set autoindenting on
	set copyindent                     " copy the previous indentation on autoindenting
	set backspace=indent,eol,start     " fix backspace indent
	" fold
	set foldmethod=indent              " lines with equal indent form a fold
	set foldlevel=99                   " opens folds < foldlevel

	" still on the fence here, i love tabs, but they are shit for alignment,
	" they work ok for the first indent
	" search tabs and replace with 4 spaces, retab won't work with noexpandtab
	" %s/\t/    /g
	" use retab with a range or visual
	" is indent with tabs align with spaces the best approach?
	" https://vim.fandom.com/wiki/Indent_with_tabs,_align_with_spaces

	" format
	set textwidth=79
		" formats lines according to these rules
		" learn gqq motions and shit
		" t autowrap text using textwidth
		" c autowrap comments insterting comment leader
		" o comment leader after using o or O in N mode, enter still works
		" q Allow formatting of comments with \"gq".
		" j Where it makes sense, remove a comment leader when joining lines.
	set formatoptions=jcqlt

	" behavior
	set mouse=a                        " Better mouse support
	set mousemodel=popup
	set splitbelow splitright          " natural split behavior splits vsplit > and split v
	set diffopt+=vertical              " Always use vertical diffs
	set hidden                         " hides buffers instead of closing them
	" make a copy of the file and overwrite the original one. ie. inode of file
	" remains unchanged otherwise links may be broken
	set backupdir=$XDG_CONFIG_HOME/vim/backup//
	" set directory=$XDG_CONFIG_HOME/vim/swap//
	" set undodir=$XDG_CONFIG_HOME/vim/undo//
	set backup                         " turn on backup option
	set writebackup                    " make backup before overwriting the current buffer
	set backupcopy=yes                 " overwrite the oroginl backup file
	" Meaningful backup name, ex: filename@2015-04-05.14:59
	au BufWritePre * let &bex = '@' . strftime("%F.%H:%M")
	" TODO delete old files or keep only number of copies
	set noswapfile                     " disable swap files
	set autoread                       " autoreload the file in Vim if it has been changed outside of Vim
	" input
	set scrolljump=6                   " lines to scroll when cursor leaves screen
	set scrolloff=3                    " minimum lines to keep above and below cursor
	set timeout timeoutlen=550         " how long wait for another key
	set noerrorbells visualbell t_vb=  " don't beep
	set ignorecase                     " ignore case when searching
	set smartcase                      " ignore case if search pattern is all lowercase, case-sensitive otherwise
	" let g:BASH_Ctrl_j='off'          " disable ctrl j, not sure if needed
	" change cursor in various different modes
	" ditch vim compabibility?
	" change visual cursor to be more visible
	" seems like gui optioms
	" visual, cursor
	if has('nvim')
		set guicursor=n-c:block,i-ci-ve:ver40,r-cr-v:hor20,o:hor50,a:Cursor/lCursor,sm:block
	else
		let &t_SI = "\<Esc>]50;CursorShape=1\x7"
		let &t_SR = "\<Esc>]50;CursorShape=2\x7"
		let &t_EI = "\<Esc>]50;CursorShape=0\x7"
		if exists('$TMUX')
			let &t_SI = "\ePtmux;\e" . &t_SI . "\e\\"
			let &t_EI = "\ePtmux;\e" . &t_EI . "\e\\"
		endif
	endif

	if has("nvim")
		" Show live preview when doing commands like :substitute
		set inccommand=nosplit
		" Hide the vim mode message in the last line (Insert, Replace, Visual)
		set noshowmode
	endif

	" visual and stuff
	set title                          " change the terminal's title
	set number                         " Show line number
	set signcolumn=yes                 " show the signcolumn, otherwise it would shift the text
	set cmdheight=2                    " more space for displaying cmd messages
	set laststatus=2                   " Always showing status line
	set path+=**                       " Display all path modificatons when tab complete
	set wildmenu                       " Visual autocomplete for command menu
	set shortmess+=c                   " don't pass messages to ins-completion-menu
	" makes search status not work
	" When this option is set, the screen will not be redrawn while executing
	" macros, registers and other commands that have not been typed.  Also,
	" updating the window title is postponed.  To force an
	" update use |:redraw|.
	" set lazyredraw
	" highlight search
	match SpellBad /\s\+$/             " Trigger SpellBad highlight group for trailing spaces
	set showmatch                      " highlight matching [{()}]
	set incsearch                      " show search matches as you type
	set hlsearch                       " highlight search terms
	set cursorline                     " highlight current line based on CursorLine
	set cursorcolumn                   " highlight column, like a crosshair
	" ampersand & with variable means option
	let &colorcolumn=join(range(81, 999),',') " highlight column based on ColorColumn highlight group
	" INDENTATION
	" indent line character
	set list
	set listchars=
	set listchars+=tab:▓░
	" set listchars+=trail:⣿
	set listchars+=trail:·
	set listchars+=extends:»
	set listchars+=precedes:«
	" set listchars+=nbsp:␣
	set listchars+=nbsp:⣿
	" set listchars+=eol:↲
	set listchars+=eol:§
	set fillchars+=vert:│
	" show linebreak
	" set showbreak=↪\
	let &showbreak='↳'

	if exists('$SHELL')
		set shell=$SHELL
	else
		set shell=/bin/sh
	endif
"}}}

"################
"#  KEYBINDS
"################

" Custom Mapping {{{
	" note about inline comments
	" i might change it cuz i would like for comments to be one the same
	" column ie 40 and any character change moves that
	" https://stackoverflow.com/questions/24716804/inline-comments-in-vimrc-mappings
	" TODO clean this file, kill bufers close
	" langmap instead of manual remaps, the most important map right now makes
	" ijkl the default navigation
	"
	function KeysAfterPlugs()
		" function to remap keys after calling plugins for overwrite
		" Shift+i to Shift+h for mass commenting etc. and vice versa should i use map
		" here?
		" splits
		" ALT
		" verical split
		noremap <M-l> <C-w>v
		" horizontal split
		noremap <M-j> <C-w>s
		" quit window TODO rethink to close buffer not window
		noremap <M-w> <C-w>q
		" equalize splits
		noremap <M-=> <C-w>=
		"" switch
		"" CTRL, had to remap for some reason
		" left switch window
		noremap <C-j> <C-w>h
		" up switch window
		noremap <C-i> <C-w>k
		" down switch window
		noremap <C-k> <C-w>j
		" right switch window
		noremap <C-l> <C-w>l
		" map alt+ijkl as arrow keys in insert mode
		inoremap <M-k> <Up>
		inoremap <M-h> <Left>
		inoremap <M-j> <Down>
		inoremap <M-l> <Right>
		cnoremap <M-k> <Up>
		cnoremap <M-h> <Left>
		cnoremap <M-j> <Down>
		cnoremap <M-l> <Right>
		" I'm using buffers instead of tabs :b #NO. switches to that buffer
		" change it cuz join is useful :help J
		noremap <silent><M-p> :bnext<CR>
		noremap <silent><M-n> :bprev<CR>
		" go back to C-h as backspace?
		map <C-h> <ESC>
		imap <C-h> <ESC>
		cmap <C-h> <ESC>
		" g is super slow
		" map <C-g> <ESC>
		" imap <C-g> <ESC>
		" cmap <C-g> <ESC>
		map <M-g> <ESC>
		imap <M-g> <ESC>
		cmap <M-g> <ESC>
		" inoremap hh <ESC>
		" also pay attention if its buffer or tab, too many times you have
		" closed whole window with alt+w
		" conflicts with smarttab extension
		inoremap <silent><expr> <TAB>
					\ pumvisible() ? "\<C-n>" :
					\ <SID>check_back_space() ? "\<TAB>" :
					\ coc#refresh()
		" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
		" trigger completion
		" NOTE something funky
		inoremap <silent><expr> <C-Space> coc#refresh()
		" close tab completion window
		autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
	endfunction
" ######################################
"                         *map-overview* *map-modes*
" Overview of which map command works in which mode.  More details below.
"      COMMANDS                    MODES ~
" :map   :noremap  :unmap     Normal, Visual, Select, Operator-pending
" :nmap  :nnoremap :nunmap    Normal
" :vmap  :vnoremap :vunmap    Visual and Select
" :smap  :snoremap :sunmap    Select
" :xmap  :xnoremap :xunmap    Visual
" :omap  :onoremap :ounmap    Operator-pending
" :map!  :noremap! :unmap!    Insert and Command-line
" :imap  :inoremap :iunmap    Insert
" :lmap  :lnoremap :lunmap    Insert, Command-line, Lang-Arg
" :cmap  :cnoremap :cunmap    Command-line
" :tmap  :tnoremap :tunmap    Terminal
"########################################
"###############################################
"                     gg
"                  <ctrl+b>
"                  <ctrl+u>
"                     -
"                     i
"                     ^
" 0 / ^ / B / b / j <   > l / e / E / w / W / $
"                     v
"                     +
"                     k
"                  <ctrl+d>
"                  <ctrl+f>
"                     G
"###############################################
	" the most important setting inverted T mapping, sue me for that heresy
	set langmap=hHjJkKiI;iIhHjJkK
	" set langmap=hHjkKiI;iIhjJkK
	" new   old
	" hH    iI
	" H was never set
	" unset I cuz it doubles H
	" map <K> <NOP>
	" map <I> <NOP>
	" Leader as , instead of the default
	let mapleader=","
	noremap ; :
	" Map emacs binding in insert mode
	" navigation
	" beggining of line
	inoremap <C-a> <HOME>
	"end of line
	inoremap <C-e> <END>
	" delete from cursors to EOL
	inoremap <C-l> <ESC>ld$A
	" inoremap <C-g> <ESC>
	" C-j is ENTER newline
	" If a line gets wrapped ko two lines, j wont skip over the '2nd line'
	nnoremap j gj
	nnoremap k gk
	" Ctrl+f / b as PgUp PgDown
	" not sure I want
	noremap <C-f> <C-b>
	noremap <C-b> <C-f>
	" search centers in the middle of the screen
	nnoremap n nzzzv
	nnoremap N Nzzzv
	" " what does it do ???
	nnoremap gV `[v`]
	" wrap current line
	noremap <Leader>j viw<ESC>mpa<CR><ESC>`p

" indent visual
	" visual and shit keybidns
	" Vmap for maintain Visual Mode after shifting > and <
	vmap < <gv
	vmap > >gv
	" Map ctrl a to copy whole file
	" nnoremap <c-a> gVG"+y
	" later or not cuz ctrl is beggining movmement
	" select all
	noremap <Leader>a ggVG

	" visual kinda
	" ToggleBetweenRelative* function {{{
		function! g:ToggleBetweenRelativeAndNothing()
			if &nu == 1 && &rnu == 1
				set nornu nonu
			else
				set nu rnu
			endif
		endfunction

		function! g:ToggleBetweenRelativeAndNumber()
			if &rnu == 1
				set nornu
			else
				set rnu
			endif
		endfunction
	" }}}

	" toggle indentline
	noremap <Leader>l :set invlist<CR>
	" toggle indentLine
	noremap <Leader>tl :IndentLinesToggle<CR>
	noremap <Leader>L :IndentLinesToggle<CR>
	" toggle indentguides
	noremap <Leader>tg :IndentGuidesToggle<CR>
	" toggle better whitespace
	noremap <Leader>ws :ToggleWhitespace<CR>
	" clear highlight ,/
	nmap <silent> <Leader>/ :nohlsearch<CR>
	" show all highlight groups
	nmap <Leader>ul :so $VIMRUNTIME/syntax/hitest.vim<CR>
" behavior {{{
	" folding {{{
	nnoremap <space> za
	" toggle all the folds
	nnoremap <Leader>tf :call ToggleFold()<CR>
	" doesn't work if set ts= is set differently than your default
	" so either change it manually or think about a way to detect it
	" <TAB>: completion.
	" inoremap <TAB> <C-R>=CleverTab()<CR>
	noremap <Leader>ts :Tab2Space<CR>
	noremap <Leader>tt :Space2Tab<CR>
	" }}}
	" yanks and pastes and buffers
	"
	" https://stackoverflow.com/questions/11489428/how-to-make-vim-paste-from-and-copy-to-systems-clipboard
	" Y works from cursor to the end of line -1 so it doesn't copy whitespace
	map Y _y$
	" Map Ctrl c & v for copy and paste from system clipboard
	vnoremap <C-c> "+y
	" map Leader c & v for copy and paste from buffer
	vnoremap <Leader>c "*y
	nnoremap <Leader>v "*p
	" LEARN USING UPPERCASE A it starts insert at the end of line, alternative to
	" $ i
	" I does the ooposite i start at the begginging
	" copy / paste
	" paste at the EOL
	" alt+1
	" ???
	nnoremap <M-1>A <ESC>p
	" not sure if works
	" paste in newline after
	nmap <Leader>p :pu<CR>
	" paste in newline before
	nmap <Leader>P :pu!<CR>
	" append at the EOL becase yank always yanks the newline character
	" outside buffer
	" noremap YY "+y<CR>
	" noremap XX "+x<CR>
	noremap <Leader>p "+gP<CR>
	" " Copy & paste to system clipboard with ,<Space>y and ,<Space>p:
	" vmap <Leader>y "+y
	" vmap <Leader>d "+d
	" nmap <Leader>p "+p
	" nmap <Leader>P "+P
	" vmap <Leader>p "+p
	" vmap <Leader>P "+P
	" nmap <Leader><Leader> V
	" move to and highlight last edited text
	" Toggle between buffer
	nnoremap \\ :b#<CR>
	" Easier buffer navigations
	" choose buffer in command line
	nnoremap gb :ls<CR>:b<Space>
	nnoremap <Leader>b :ls<CR>:b<Space>
	" buffers 1-10
	" noremap <silent> <Leader>1 :b 1<CR>
	" noremap <silent> <Leader>2 :b 2<CR>
	" noremap <silent> <Leader>3 :b 3<CR>
	" noremap <silent> <Leader>4 :b 4<CR>
	" noremap <silent> <Leader>5 :b 5<CR>
	" noremap <silent> <Leader>6 :b 6<CR>
	" noremap <silent> <Leader>7 :b 7<CR>
	" noremap <silent> <Leader>8 :b 8<CR>
	" noremap <silent> <Leader>9 :b 9<CR>
	" Close buffer - not consistent
	noremap <silent><M-c> :bd<CR>
	noremap <silent><Leader>c :bd<CR>
	noremap <silent><Leader>w :bd<CR>


	" cheatsheet
	" later

	"noremap <silent> <Leader> :WhichKey '<Space>'<CR>
	" fucks uo everything, buffers, why?
	" 
	" noremap <Leader>re :so %<CR>
	" maps ,s to :w for faster saving and proper echo
	noremap <Leader>s :w<CR>
	" noremap <Leader>w :w<CR>
	noremap <Leader>W :w!<CR>
	" quickly quit editing without save
	" too many mistakes because q is record macro
	noremap <Leader>q :qa!<CR>
	noremap <Leader>Q :qa!<CR>
	noremap <Leader>z :qa!<CR>
	noremap <Leader>Z :qa!<CR>

	noremap <Leader>o :Files<CR>
	noremap <Leader>f :FZF<CR>
	" fzf in HOME
	noremap <Leader>F :FZF ~<CR>
	" fzf in ROOT
	" nnoremap <Leader>FF :sudo FZF /<CR>
	" edit and source
	if has('nvim')
		noremap <Leader>sv :source $MYVIMRC<CR>
		noremap <Leader>ev :vsplit $MYVIMRC<CR>
	else
		noremap <Leader>sv :source $MYVIMRC<CR>
		noremap <Leader>ev :vsplit $MYVIMRC<CR>
	endif

	" COMMANDS
	" Allow saving of files as sudo when I forgot to start vim using sudo.
	" :w!! - it will push the file through sudo tee to the current filename (%).
	cmap w!! w !sudo tee > /dev/null %
	" map <Leader>W :w !sudo tee % >/dev/null
	" }}}
	" session management {{{
		noremap <Leader>so :OpenSession<Space>
		noremap <Leader>ss :SaveSession<Space>
		noremap <Leader>sd :DeleteSession<CR>
		noremap <Leader>sc :CloseSession<CR>
	" }}}
" }}}
	" Set F1-F12 shortcut keys. {{{
		" F1 : toggles signify column, switches to relative line number and
		" turns on indentation lines
		noremap <F1> :SignifyToggle<CR>:call g:ToggleBetweenRelativeAndNothing()<CR>:IndentLinesToggle<CR>
		" F2 : toggles between absolute and relative line number
		noremap <F2> :call g:ToggleBetweenRelativeAndNumber()<CR>
		" already have plugin that does that?
		" noremap <F4> :Autoformat<CR>
		" reindent whole document according to tabstop
		" problem is it seldom works and Im not sure if it uses
		" tabs for indentation and spaces for alignment
		" F4 : reindent whole document according to tabstop
		noremap <F4> :RetabIndent[!] [tabstop]<CR>
		" remove trailing spaces
		noremap <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>
		" similar to the :retab command, with the exception that it affects all
		" and only whitespace at the start of the line, changing it to suit
		" your current (or new) tabstop and expandtab setting. With the bang
		" (!) at the end, the command also strips trailing whitespace.  Before
		" copy
		nnoremap <silent> <F7> :set nu<CR> :GitGutterToggle<CR> :IndentLinesToggle<CR>
		nnoremap =<F7> :set nu<CR> :GitGutterToggle<CR> :IndentLinesToggle<CR>
		nnoremap <silent> <F8> :set nonu<CR> :GitGutterToggle<CR> :IndentLinesToggle<CR>
		nnoremap =<F8> :set nonu<CR> :GitGutterToggle<CR> :IndentLinesToggle<CR>
		" set paste mode
		nnoremap <silent> <F12> :set paste<CR>
		nnoremap =<F12> :set nopaste<CR>
	" }}}

	" operator mode mappings
	" Custom Text Objects {{{
		" ie = inner entire buffer
		onoremap ie :exec "normal! ggVG"<CR>
		" iv = current viewable text in the buffer
		onoremap iv :exec "normal! HVL"<CR>
		" inside last parenthesis operator
		onoremap il( :<c-u>normal! F)vi(<CR>
	" }}}
" }}}

" Plugin Configurations {{{
	" multi cursor {{{
		let g:multi_cursor_use_default_mapping = 0
		let g:multi_cursor_next_key = '<C-n>'
		let g:multi_cursor_prev_key = '<C-p>'
		let g:multi_cursor_skip_key = '<C-x>'
		let g:multi_cursor_quit_key = '<C-h>'
	" }}}

	" quickr-preview {{{
		let g:quickr_preview_exit_on_enter = 0
		let g:quickr_preview_on_cursor = 1
		let g:quickr_preview_position = 'below'
		" disable key mappings for quick previewr
		let g:quickr_preview_keymaps = 0
		let g:quickr_preview_size = '8'
		noremap \p :InstantMarkdownPreview<CR>
	" }}}

	" vim-signify {{{
		let g:signify_vcs_list = [ 'git' ]
		nnoremap <Leader>hd :SignifyHunkDiff<CR>
		nnoremap <Leader>hu :SignifyHunkUndo<CR>
	"}}}

	" vimwiki {{{
		" Do not use vimwiki filetype for non-vimwiki md files
		let g:vimwiki_global_ext = 0
		" if the path is changed, remember to update the sCReenshot sCRipt as well
		let g:vimwiki_list = [{'path': '~/vimwiki/',
							\ 'syntax': 'markdown',
							\ 'ext': '.md',
							\ 'index': 'README',}]
		let g:vimwiki_conceallevel = 0
	"}}}

	" vim-markdown {{{
		let g:vim_markdown_conceal = 0
		let g:vim_markdown_auto_insert_bullets = 0
	"}}}

	" vim-markdown-toc {{{
		let g:vmt_fence_text = 'Do not edit, run `:UpdateToc` to update'
		let g:vmt_auto_update_on_save = 0
	"}}}

	" vim-instant-markdown {{{
		let g:instant_markdown_slow = 0
		let g:instant_markdown_autostart = 0
		let g:instant_markdown_mathjax = 1
		let g:instant_markdown_logfile = '/tmp/instant_markdown.log'
		let g:instant_markdown_autoscroll = 1
		let g:instant_markdown_browser = "google-chrome-stable --new-window"

	" }}}

	" tagbar {{{
		let g:tagbar_autofocus = 1
		" override because of my mappings
		let g:tagbar_map_togglecaseinsensitive = 'I'
		let g:tagbar_type_vimwiki = {
				\ 'ctagstype' : 'vimwiki',
				\ 'kinds' : [
						\ 'h:headings',
				\ ],
			\ 'sort' : 0
		\ }
		let g:tagbar_width = 30
		let g:tagbar_left = 1
		" nnoremap <M-n> :TagbarToggle<CR>
		" nnoremap \tb :TagbarToggle<CR>
	"}}}

	" fzf & searching stuff {{{
	" TODO rebind
   " - Customizable extra key bindings for opening selected files in different
   "   ways
		let g:fzf_action = {
				\ 'alt-t': 'tab split',
				\ 'alt-k': 'split',
				\ 'alt-l': 'vsplit' }
		" Mapping selecting Mappings
		" searching through current mappings
		" normal
		nmap <Leader><TAB> <plug>(fzf-maps-n)
		" visual
		xmap <Leader><TAB> <plug>(fzf-maps-x)
		" operator pending
		omap <Leader><TAB> <plug>(fzf-maps-o)
		" Insert mode completion
		" rethink to make it consistent with emacs and vim movements
		imap <C-x><C-k> <plug>(fzf-complete-word)
		imap <C-x><C-f> <plug>(fzf-complete-path)
		imap <C-x><C-j> <plug>(fzf-complete-file-ag)
		imap <C-x><C-l> <plug>(fzf-complete-line)
		set rtp+=~/.local/lib/fzf
		" ripgrep
		" make it consistent with zshrc
		" it respects env so maybe disable?
		" if executable('rg')
		"     let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
		"     set grepprg=rg\ --vimgrep
		" endif

		try
			let git_root_dir = systemlist('git rev-parse --show-toplevel')[0]
		catch "E684"
			" vim throws this error
		endtry

		" Finding files with preview equivalent to (C-T) in terminal (set base dir to git root)
		" make sure the keybind dont double, tag stack?
		if v:shell_error != 0
			echom "No git directory found"
			nnoremap <C-t> :Files<SPACE><CR>
		else
			nnoremap <C-t> :GitFiles<SPACE><CR>
		endif

		" Fuzzy find words (set base dir to git root)
		command! -bang -nargs=* Rg
			\ call fzf#vim#grep(
			\   'rg --column --line-number --no-heading --smart-case '.shellescape(<q-args>), 1,
			\   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

		" Finding files with preview equivalent to (C-T) in terminal (set base dir to git root)
		command! -bang -nargs=? -complete=dir Files
			\ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'dir': getcwd()}), <bang>0)

		command! -bang -nargs=? -complete=dir GitFiles
			\ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

		" fzf floating window {{{
		if has('nvim')
			let $FZF_DEFAULT_OPTS .= ' --border --margin=0,2'
			function! FloatingFZF()
				let width = float2nr(&columns * 0.9)
				let height = float2nr(&lines * 0.6)
				let opts = { 'relative': 'editor',
						\ 'row': (&lines - height) / 2,
						\ 'col': (&columns - width) / 2,
						\ 'width': width,
						\ 'height': height }

				let win = nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
				call setwinvar(win, '&winhighlight', 'NormalFloat:Normal')
			endfunction
			let g:fzf_layout = { 'window': 'call FloatingFZF()' }
		endif
		" }}}
	" }}}

	" ale {{{
		let g:ale_completion_tsserver_autoimport = 0
		let g:ale_set_quickfix = 0
		let g:ale_set_highlights = 1

		" " Error message format
		let g:ale_echo_msg_error_str = 'E'
		let g:ale_echo_msg_warning_str = 'W'
		let g:ale_echo_msg_format = '[%linter%] %s [%severity%] [%code%]'
		" Run :ALEFix upon save
		let g:ale_fix_on_save = 1
		" general ALE config
		let g:ale_fixers = {'*': ['remove_trailing_lines']}
		" python ALE configurations
		let g:ale_fixers = {'python': ['isort', 'autopep8', 'black']}
		let g:ale_python_autopep8_options = "-i"
		let g:ale_python_black_options = "-l 80"
		let g:ale_python_mypy_options = "--ignore-missing-imports --disallow-untyped-defs"
		let g:ale_python_flake8_options = "--max-line-length=80"
		let g:ale_python_pylint_use_msg_id = 1
		" error navigation
		nmap <silent> ,e <Plug>(ale_previous_wrap)
		nmap <silent> ,d <Plug>(ale_next_wrap)
	"}}}

		" helper function {{{
			function! DeviconFileType()
				return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
			endfunction
			function! DeviconFileFormat()
				return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
			endfunction

			function! HorizontalSeperator()
				let l:fillChar = '─'
				let l:fileName = ' ' . expand('%:t') . ' '
				let l:fileNameLength = len(fileName)
				let l:totalCharsNeeded = winwidth(0) - 2
				let l:charsToFill =  totalCharsNeeded - fileNameLength

				if l:fileNameLength
					let l:left_part = repeat(fillChar, l:charsToFill/2)
					let l:middle_part = fileName
					let l:right_part = repeat(fillChar, l:charsToFill/2)

					" if odd
					if charsToFill % 2
						let l:right_part = right_part . fillChar
					endif
				else
					return repeat(fillChar, winwidth(0) - 2)
				endif

				return l:left_part . l:middle_part . l:right_part
			endfunction

		"  }}}
	" }}}

		" Airline overrides, colors hardcoded for now {{{
		let g:airline_theme='jellybeans'
		" let g:airline_theme='base16_monokai'
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
		let g:airline_powerline_fonts = 1               " enable unicode powerline fonts, TODO find how to edit
		" let g:airline_highlighting_cache = 1            " caches hl groups, supposedly faster
		let g:airline#extensions#tabline#enabled = 1    " always have tabs
		let g:airline#extensions#branch#enabled = 1
		let g:airline#extensions#ale#enabled = 1
		let g:airline#extensions#tagbar#enabled = 1
		"let g:airline_skip_empty_sections = 1
		" }}}
	" NERDtree {{{
		" open NERDTree browsing with alt+m
		" noremap <M-m> :NERDTreeToggle<CR>
		noremap <silent><M-m> :NERDTreeToggle<CR>
		" previously ctrl + jk
		" change to something else to keep consistency
		let g:NERDTreeMapJumpPrevSibling = '<M-f>'
		let g:NERDTreeMapJumpNextSibling = '<M-g>'
		" Show line numbers in NERDTree
		let NERDTreeShowLineNumbers = 0
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
		let g:NERDTreeHighlightCursorline = 1           " higlight directory
		let g:NERDTreeChDirMode = 2                     " CWD is changed whenever the tree root is changed
		let g:NERDTreeIgnore = ['.git$[[dir]]', '\.serverauth\.[0-9]{3,}$', '\~$']  " ignore list, REGEX, the serverauth part doesn't work yet
		let g:NERDTreeMouseMode = 2                     " single click opens directory, double - files
		let g:NERDTreeShowHidden = 0                    " hidden files by default
		let g:NERDTreeAutoDeleteBuffer = 1
		let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
		let g:NERDTreeWinSize = 35
		autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
		"" }}} NERDtree

		" {{{ NERDTree commenter
		let g:NERDSpaceDelims = 1                       " spaces after comment delimiters by default
		let g:NERDCompactSexyComs = 1                   " compact syntax for prettified multi-line comments
		let g:NERDDefaultAlign = 'left'                 " line-wise comment delimiters flush left instead of following code indentation
		let g:NERDTrimTrailingWhitespace = 1            " Enable trimming of trailing whitespace when uncommenting
		" }}}

		" better whitespace highlights traling whitespace only
		let g:better_whitespace_enabled = 1
		let g:strip_whitespace_on_save = 1
		let g:better_whitespace_ctermcolor = 14           " It works along the indent color, because indent highlights during writing for example
		" indentline {{{
		let g:indentLine_enabled = 0
		let g:indentLine_char_list = ['|', '¦', '┆', '┊']
		let g:indentLine_bufTypeExclude = ['help', 'Help', 'terminal', 'man', 'Man']
		let g:indentLine_bufNameExclude = ['_.*', 'NERD_tree.*', 'man://.*', 'MAN://*', 'help*', 'Help*']
		" By default identLine set conceal level to 2 thus and causing some concealed
		" text to be completely hidden. ie. Text surrounded by ``
		let g:indentLine_fileTypeExclude = ['json', 'md']
		let g:indentLine_showFirstIndentLevel = 1
		" let g:indentLine_setConceal = 1
		let g:indentLine_setConceal = 2
		" default ''.
		" " n for Normal mode
		" " v for Visual mode
		" " i for Insert mode
		" " c for Command line editing, for 'incsearch'
		" default value is \"inc"
		" let g:indentLine_concealcursor = ""
		let g:indentLine_concealcursor = 1
		let g:indentLine_faster = 1
		" let g:indentLine_color_term = 15
		let g:indentLine_color_term = 10
		let g:indentLine_bgcolor_term = 0
		" let g:indentLine_color_gui = '#3b4252'
		" let g:indentLine_bgcolor_gui = 'NONE'
                " Specify whether the first indent level should be shown.
                " This is useful if you use indentLine in combination with
                " |listchars| in order to show tabs.
                " Default value is 0.
		" }}}
		" indentguides {{{
			"" indentguides, kinda at odds with my lines and indentline plug, i feel like it should highlight
		" background not characters
		let g:indent_guides_enable_on_vim_startup = 1
		let g:indent_guides_auto_colors = 0
		" colors IndentGuides
		autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=8 ctermfg=4
		" its not 16 colors bro
		autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=237 ctermfg=4
		" }}}
		" fzf {{{
		" Default fzf layout
		" - down / up / left / right
		let g:fzf_layout = { 'down': '~60%' }
		" In Neovim, you can set up fzf window using a Vim command
		let g:fzf_layout = { 'window': 'enew' }
		let g:fzf_layout = { 'window': '-tabnew' }
		" Customize fzf colors to match your color scheme
		let g:fzf_colors = {
						\ 'fg':      ['fg', 'Normal'],
						\ 'bg':      ['bg', 'Normal'],
						\ 'hl':      ['fg', 'Comment'],
						\ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
						\ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
						\ 'hl+':     ['fg', 'Statement'],
						\ 'info':    ['fg', 'PreProc'],
						\ 'prompt':  ['fg', 'Conditional'],
						\ 'pointer': ['fg', 'Exception'],
						\ 'marker':  ['fg', 'Keyword'],
						\ 'spinner': ['fg', 'Label'],
						\ 'header':  ['fg', 'Comment'] }
		" Enable per-command history.
		" CTRL-N and CTRL-P will be automatically bound to next-history and
		" previous-history instead of down and up. If you don't like the change,
		" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
		let g:fzf_history_dir = "~/.local/share/fzf-history"
		" }}}
		let g:acp_enableAtStartup = 0                   " Disable AutoComplPop.
		let g:ackprg = 'ag --vimgrep'                   " Silver searcher utility in vim
	" vim-subversive {{{
	" replaces / substitutes motion learn
	" ie to replace until end of file first select the word visually v-s-G
	" or have a word in a buffer
		nmap s <plug>(SubversiveSubstituteRangeConfirm)
		xmap s <plug>(SubversiveSubstituteRangeConfirm)
		nmap ss <plug>(SubversiveSubstituteWordRangeConfirm)
		" s for substitute replaces with the current buffer
		" nmap s <plug>(SubversiveSubstitute)
		" nmap ss <plug>(SubversiveSubstituteLine)
		" nmap S <plug>(SubversiveSubstituteToEndOfLine)
	" }}}
	" supertab {{{
		let g:SuperTabDefaultCompletionType = "<C-n>"
	" }}}
	" coc {{{
		" add npm to path
		let g:coc_node_path = expand("$NVM_DIR") .  '/versions/node/v10.18.0/bin/node'
		let g:coc_node_path = '/usr/bin/node'
		let g:python3_host_prog = '/usr/bin/python'
		let g:python_host_prog = '/usr/bin/python2'

		" Smaller updatetime for CursorHold & CursorHoldI
		" diagnostic messages default 4000.
		set updatetime=400

		" show_documentation function {{{
			function! s:show_documentation()
				if (index(['vim','help'], &filetype) >= 0)
					execute 'h '.expand('<cword>')
				else
					call CocAction('doHover')
				endif
			endfunction
		" }}}
		" Highlight symbol under cursor on CursorHold (use with coc-highlight)
		autocmd CursorHold * silent call CocActionAsync("highlight")
" completion ??
		augroup mygroup
			autocmd!
			" Setup formatexpr specified filetype(s).
			autocmd FileType typescript,json setl formatexpr=CocAction("formatSelected")
			" Update signature help on jump placeholder
			autocmd User CocJumpPlaceholder call CocActionAsync("showSignatureHelp")
		augroup end


		" Create mappings for function text object, requires document symbols feature of languageserver
		xmap if <Plug>(coc-funcobj-i)
		xmap af <Plug>(coc-funcobj-a)
		omap if <Plug>(coc-funcobj-i)
		omap af <Plug>(coc-funcobj-a)

		" Use `:Format` to format current buffer
		command! -nargs=0 Format :call CocAction('format')

		" Use `:Fold` to fold current buffer
		command! -nargs=? Fold :call CocAction('fold', <f-args>)

		" use `:OR` for organize import of current buffer
		command! -nargs=0 OR   :call CocAction('runCommand', 'editor.action.organizeImport')

		" Use K to show documentation in preview window
		" noremap better or worse?
		nnoremap <silent> K :call <SID>show_documentation()<CR>

		" Remap keys for gotos
		nmap <silent> gd <Plug>(coc-definition)
		nmap <silent> gy <Plug>(coc-type-definition)
		" remember that langmap i=h
		nmap <silent> gi <Plug>(coc-implementation)
		nmap <silent> gr <Plug>(coc-references)
		" Use <c-space> to trigger completion.
		inoremap <silent><expr> <C-Space> coc#refresh()


		" Remap for rename current word
		nmap \rn <Plug>(coc-rename)

		" Remap for format selected region
		xmap \f  <Plug>(coc-format-selected)
		nmap \f  <Plug>(coc-format-selected)

		" Use `[g` and `]g` to navigate diagnostics
		nmap <silent> [g <Plug>(coc-diagnostic-prev)
		nmap <silent> ]g <Plug>(coc-diagnostic-next)

		" Remap for do codeAction of selected region, ex: `<Leader>aap` for current paragraph
		xmap \a  <Plug>(coc-codeaction-selected)
		nmap \a  <Plug>(coc-codeaction-selected)

		" Remap for do codeAction of current line
		nmap \ac  <Plug>(coc-codeaction)

		" Using CocList
		" Show all diagnostics
		nnoremap <silent> \a  :<C-u>CocList diagnostics<CR>
		" Manage extensions
		nnoremap <silent> \e  :<C-u>CocList extensions<CR>
		" Show commands
		nnoremap <silent> \c  :<C-u>CocList commands<CR>
		" Find symbol of current document
		nnoremap <silent> \o  :<C-u>CocList outline<CR>
		" Search workspace symbols
		nnoremap <silent> \s  :<C-u>CocList -I symbols<CR>
		" Do default action for next item.
		nnoremap <silent> \j  :<C-u>CocNext<CR>
		" Do default action for previous item.
		nnoremap <silent> \k  :<C-u>CocPrev<CR>
		" Resume latest coc list
		nnoremap <silent> \p  :<C-u>CocListResume<CR>
	" }}}
	" vim-devicons {{{
		let g:DevIconsEnableFoldersOpenClose = 1
		" quickfix to prevent orange color folder
		highlight! link NERDTreeFlags NERDTreeDir
	" }}}
	" vim-maximizer {{{
		nnoremap <F11> :MaximizerToggle<CR>
		vnoremap <F11> :MaximizerToggle<CR>gv
		inoremap <F11> <C-o>:MaximizerToggle<CR>
	"
	" }}}
	" vim-polyglot {{{
		" polylglot clashes with vimwiki plugin
		let g:polyglot_disabled = ['markdown']
	" }}}
	" highlightedyank {{{
		" highlight yanked for 3s
		let g:highlightedyank_highlight_duration = 4500
	" }}}
	" SimpylFold {{{
	" wrong folds atm, i dont know how to fold inner folds
		let g:SimpylFold_docstring_preview=1             " docstrings for folded code
	" }}}
	" Emmet {{{
		let g:user_emmet_leader_key = '<C-Z>'
		let g:user_emmet_mode = 'n'    "only enable normal mode functions.
		let g:user_emmet_mode = 'inv'  "enable all functions, which is equal to
		let g:user_emmet_mode = 'a'    " enable all function in all mode.
	" }}}
" }}}

" https://www.vimfromscratch.com/articles/vim-for-python/

"  Plugins install {{{
	call plug#begin()
		" essentials | navigation {{{
		" file explorer
			Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
			" manpager in vim
			" Plug 'lambdalisue/vim-manpager'
				" do not create mapping in manpage buffers
				" let g:no_man_maps = 1
				" fold manpages with indent and foldnest
				" let g:ft_man_folding_enable = 1
				" let b:man_default_sections = '3,2'
				" let g:man_hardwrap = 1
			" helpers for UNIX, using it mostly for syntax using sudo -e
			" better man than built
			Plug 'jez/vim-superman'
			Plug 'tpope/vim-eunuch'
		" }}}
	" PONDER Plug 'ervandew/supertab'
	" text and file manipulation
		" Plugin outside ~/.vim/plugged with post-update hook, i think it's in
		" the same place as zinit, should i duplicate?
		" from junegunn site
		"
" Plugin outside ~/.vim/plugged with post-update hook
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
		Plug 'junegunn/fzf', { 'dir': '~/.local/lib/fzf', 'do': './install --all' }
		Plug 'junegunn/fzf.vim'
		Plug 'tpope/vim-surround'               " surround text easily with S
		Plug 'tpope/vim-repeat'                 " let's you repeat (using '.') not only native commands
		Plug 'tpope/vim-commentary'
		""" no clue how it works
		Plug 'ronakg/quickr-preview.vim'
		" Plug 'easymotion/vim-easymotion'
		" add some square bracket mappings
	" }}}
	" IDE {{{
	"**** AUTO COMPLETE
		Plug 'neoclide/coc.nvim', {'branch': 'release'} " Mainly for autocompletion, powerful server
		Plug 'sheerun/vim-polyglot'             " loaded on demand language packs
		Plug 'w0rp/ale'                         " linting - syntax checking and symantic errors
	" }}}
	" filetype markdown {{{
		" Plug 'vimwiki/vimwiki'
		"
		":GenTocGFM -> generate toc with github flavoured markdown
		Plug 'mzlogin/vim-markdown-toc', { 'for': 'vimwiki' }
		Plug 'suan/vim-instant-markdown', { 'for': 'markdown' }
	" }}}
	" filetype javascript {{{
		Plug 'pangloss/vim-javascript', {'for': 'js'}
	" }}}
	" git integration {{{
		Plug 'tpope/vim-fugitive'               " git wrapper
		Plug 'airblade/vim-gitgutter'           " git diff in the sign column
		Plug 'tpope/vim-rhubarb'                " hub, required by fugitive to :Gbrowse
		" do i need this
		Plug 'gabesoft/vim-ags'                 " ag or rg for vim
		" indicate added/modified/removed lines in a file
		Plug 'mhinz/vim-signify'
		" git commit browser
		Plug 'junegunn/gv.vim'
	" }}}
	" THEMES | asthethics {{{
		" Plug 'joshdick/onedark.vim'
		Plug 'fcpg/vim-fahrenheit'              " this one is my own mod, I need to upload it
		Plug 'chriskempson/base16-vim'
		Plug 'tomasiser/vim-code-dark'
		Plug 'tomasr/molokai'
		Plug 'ryanoasis/vim-devicons'
		"" PROMPTLINE STATUSLINE
		Plug 'vim-airline/vim-airline'
		Plug 'vim-airline/vim-airline-themes'
		" Plug 'itchyny/lightline.vim'
		" Plug 'maximbaz/lightline-ale'
		"" indentation line
		" Plug 'Yggdroot/indentLine'              " vertical lines at each indentation level
		Plug 'nathanaelkane/vim-indent-guides'  " visually displaying idnent levels in code
		Plug 'blueyed/vim-diminactive'    " dim inactive windows
			"" {{{
				let g:diminactive_enable_focus = 0
				" let g:diminactive_debug = 1
			"" }}}
		Plug 'machakann/vim-highlightedyank'    " highlights yanked text
		Plug 'tmux-plugins/vim-tmux-focus-events'
	"  }}}
	"  bloat rethink {{{
		Plug 'svermeulen/vim-subversive'
		" for toggling between different variant
		Plug 'tpope/vim-abolish'
		" convert between decimal, hex, octal and binary representation
		Plug 'glts/vim-radical'
		" dependency for vim-radical
		Plug 'glts/vim-magnum'
	"  }}}
	" utilities {{{
		" workflow | productivity
		Plug 'xolox/vim-notes'                 " notes in a buffer
		Plug 'godlygeek/tabular'
		Plug 'obreitwi/vim-sort-folds'   " sorts folds visually <Leader>sf
		Plug 'szw/vim-maximizer'         " maximizes and restores current window
		Plug 'tpope/vim-unimpaired' " very cool adds plethora of ] mappings file manipulation text etc
		Plug 'xolox/vim-misc'               " some collection of plugins
		" Plug 'xolox/vim-session'            " restores vim edition sesssions
		" theme helper, colors
		Plug 'vim-scripts/CSApprox'             " color approximation to 88 or 256 colors
		" Plug 'Rykka/colorv.vim'          " makes it easier to modify color
		Plug 'mattn/webapi-vim'          " needed for fetching schemes online
		Plug 'gerw/vim-HiLinkTrace'             " :HLT! lets you track highlight groups
	" }}}
	" filetype HTML {{{
		Plug 'mattn/emmet-vim'                  " expands abbreviations
	" }}}
	" syntax {{{
	Plug 'liuchengxu/vista.vim'  "better than tagbar
	" Plug 'majutsushi/tagbar'                " displays tags in a window
	Plug 'universal-ctags/ctags'            " index of TAGS, helps tools locate items
	Plug 'Chiel92/vim-autoformat'           " formats code with a button or on save
	Plug 'ntpeters/vim-better-whitespace'   " remove trailing whitespace
	Plug 'gentoo/gentoo-syntax'             " syntax highlight specific for gentoo files
	Plug 'zinit-zsh/zinit-vim-syntax'       " syntax highlighting for zinit vim files
	"**** TEXT EDITING
	" Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
	Plug 'dpc/vim-smarttabs'                " indent with tabs alignt with spaces
	Plug 'junegunn/vim-easy-align'          " great tool, learn alignment
	Plug 'scrooloose/nerdcommenter'         " easy commenting via leader
	Plug 'tmhedberg/SimpylFold'             " foldingPlug
	" Plug 'terryma/vim-multiple-cursors'     " sublime-like multiple cursors
	"**** SNIPPETS
	"Plug 'SirVer/ultisnips'                " snippet engine
	"Plug 'honza/vim-snippets'              " fast snippets, inserts, placeholders
	"**** SYNTAX | GENERIC SUPPORT AND FORMAT
	" Plug 'liuchengxu/vim-which-key'         " cheat sheet for mappings

call plug#end()
"}}}

	" colorscheme fahrenheit
" Colorscheme dunno about the place {{{
" https://github.com/kovidgoyal/kitty/issues/160
" https://vi.stackexchange.com/questions/12104/what-does-set-background-dark-do
	" set background=dark
	" set termguicolors                      " truecolor, but I'm partial to base16
	" " fix for 8?
	" let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
	" let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"
	" nvim uses colons
	" let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	" let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	" set t_Co=16                           " will only use the colors in your .Xresources
	" set t_Co=256                           " will only use the colors in your .Xresources
	" =256
	syntax on
	" let base16colorspace=256  " Access colors present in 256 colorspace
	colorscheme fahrenheit
	" hi StatusLineNC ctermbg=2
	" somehow when refreshing some colors change
	" think about augroup because that might be the problemhttps://github.com/chriskempson/base16-vim
	" colorscheme base16_monokai
	" colorscheme base16-default-dark
	" :help 'listchars'
	" Fold color
	hi Folded ctermbg=8 ctermfg=10
	" hi Folded ctermfg=4
	" listchars color
	" :hi SpecialKey ctermfg=grey guifg=grey70
	" the cursorline option is enabled,
	" the CursorLine highlight group has a background color set.
	" hi! CursorLine ctermbg=8
	" hi ColorColumn gui=reverse cterm=reverse
	" links groups
	hi! link EndOfBuffer ColorColumn
	hi VertSplit ctermbg=5
	hi! SpecialKey ctermbg=8 ctermfg=2
	" hi SpecialKey ctermbg=15
	"
	hi! link CursorLine CursorColumn
	" hi! SpecialKey ctermbg=15 ctermfg=2
		" autocmd VimEnter * :hi SpecialKey ctermbg=2 ctermfg=10
		" autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=15 ctermfg=4
	" au VimEnter * call matchadd('SpecialKey', '^\s\+', -1)
	" au VimEnter * call matchadd('SpecialKey', '\s\+$', -1)
" }}}
""

" makr vman use different color scheme, disable column, wrap, show relative
" linenumber
" my shit {{{
	" keybinds loading after plugins
	autocmd VimEnter * call KeysAfterPlugs()
" }}}
"*****************************************************************************
"******** Functions
"*****************************************************************************

" completion functions {{{
	function! s:check_back_space() abort
		let col = col('.') - 1
		return !col || getline('.')[col - 1]  =~# '\s'
	endfunction
" }}}

" indent functions {{{
	"" change indent from spaces to tabs and vice versa
	command! -nargs=? -range=% Space2Tab call IndentConvert(<line1>,<line2>,0,<q-args>)
	command! -nargs=? -range=% Tab2Space call IndentConvert(<line1>,<line2>,1,<q-args>)
	command! -nargs=? -range=% RetabIndent call IndentConvert(<line1>,<line2>,&et,<q-args>)

	" function! Indenting(indent, what, cols)
	"     let spccol = repeat(' ', a:cols)
	"     let result = substitute(a:indent, spccol, '\t', 'g')
	"     let result = substitute(result, ' \+\ze\t', '', 'g')
	"     if a:what == 1
	"         let result = substitute(result, '\t', spccol, 'g')
	"     endif
	"     return result
	" endfunction
	" Convert whitespace used for indenting (before first non-whitespace).
	" what = 0 (convert spaces to tabs), or 1 (convert tabs to spaces).
	" cols = string with number of columns per tab, or empty to use 'tabstop'.
	" The cursor position is restored, but the cursor will be in a different
	" column when the number of characters in the indent of the line is changed.
	function! IndentConvert(line1, line2, what, cols)
		let savepos = getpos('.')
		let cols = empty(a:cols) ? &tabstop : a:cols
		execute a:line1 . ',' . a:line2 . 's/^\s\+/\=Indenting(submatch(0), a:what, cols)/e'
		call histdel('search', -1)
		call setpos('.', savepos)
	endfunction
" }}}

" folding function {{{
	"" key: <Leader> tf
	function! ToggleFold()
		if &foldlevel >= 20
			" normal! zM<CR> (folds all)
			set foldlevel=0
		else
			" normal! zR<CR> (unfolds everything)
			set foldlevel=40
		endif
	endfunction
" }}}

" RANDOMSHIT {{{
	" tips `` goes to the previous place in the doc
	"
	" You can use _y$. What _ does is [count] - 1 lines downward, on the first
	" non-blank character |linewise|.. Without the [count], it's the same as ^,
	" but _ is much easier to reach on the keyboard

	" :help local-additions
	" lists it?
" }}}
" visual mode shit
" 1v selects area equal to the original after d or c, 2 twice as big etc
" learn about g and j w and e is the same? jumps to the next word and b
" previous make E and B into $ and ^ i think
"
"f[orward]
"https://vimsheet.com/
"https://devhints.io/vim
" visual
" v 100 gg go to line 100 just like nomrla
" d[elete]
" c[hange]
" ]p under current indentation level seems super cool
" use ranger or nnn or something
" https://github.com/mcchrish/nnn.vim
" gv reselects
" https://www.cs.swarthmore.edu/oldhelp/vim/selection.html
" https://stackoverflow.com/questions/49020606/selecting-entire-word-that-includes-dashes
" ,d jumpts to next shellcheck informatio,d jumpts to next shellcheck
" informationn
" esdf for left hand
" emacs movements make consistent
" C-a beggining of the line - ^   in vim
" C-e end of line           - $
" leanr about sections and paragraphs
" echo &variable, useful
" also var+= adds the variable, maybe fix for some plugins
