source ~/.vim/.plug.vim
set number
"tab 4
set autoindent noexpandtab tabstop=4 shiftwidth=4
" map h <insert>
" remap h to insert and use ijkl for inverse T cursor movement
map i <Up>
map j <Left>
map k <Down>
noremap h i
" Ctrl + h acts as escape
inoremap <C-h> <Esc>

" load vim-plug
