" source $VIMRUNTIME/defaults.vim
colorscheme nord
syntax enable " enable syntax processing
set termguicolors " activates bold syntax highlighting
set tabstop=4 " number of visual spaces per TAB
set softtabstop=4 " number of spaces in tab when editing
set shiftwidth=4 " number of spaces in one level of indentation
set expandtab " tabs are spaces
set number " show line numbers
set showcmd " show command in bottom bar
set cursorline " highlight current line
filetype indent on " load filetype-specific indent files
set wildmenu " visual autocomplete for command menu
set incsearch " search as characters are entered
set hlsearch " highlight matches
set foldenable " enable folding
set foldmethod=syntax " enable method folding
let mapleader=","

" Map specific file types to the desired syntax
au BufReadPost *.qml set syntax=html
au BufReadPost *.rasi set syntax=css
au BufReadPost *.txt set foldmethod=indent
au BufNewFile,BufRead *.txtmt setf mathdoc

" Folding settings
"set foldlevelstart=10 " open most folds by default
"set foldmethod=expr
"set foldexpr=nvim_treesitter#foldexpr()
" Save custom foldings on file exit
"autocmd BufWinLeave *.* mkview
"autocmd BufWinEnter *.* silent loadview

" Enable vim-julia-plugin on .txt files
" let latex_to_unicode_file_types = ["text"]

" Configure jdhao/better-escape.vim
let g:better_escape_shortcut = ['jk', 'jj', 'kj']
    " let g:better_escape_interval = 150

" General keybindings
nnoremap ; :
" nnoremap <CR> o<esc>k
nnoremap <CR> i<CR><esc>k$
vnoremap <CR> i<CR><esc>k$
" inoremap jk <esc>

" Leader keybindings
nmap <leader>p "0p
nmap <leader>P "0P
nmap <leader>' ysiw'
nmap <leader>" ysiw"
nmap <leader>` ysiw`
nmap <leader>< bi<<esc>ea><esc>
nmap <leader>div ysiw<div>

" Move between Vimdows
nmap <space> <C-w>
" nmap <space>h <C-w>h
" nmap <space>j <C-w>j
" nmap <space>k <C-w>k
" nmap <space>l <C-w>l
" nmap <space>H <C-w>H
" nmap <space>J <C-w>J
" nmap <space>K <C-w>K
" nmap <space>L <C-w>L
" nmap <up> <C-w>+
" nmap <down> <C-w>-
" nmap <left> <C-w><
" nmap <right> <C-w>>
