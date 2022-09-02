" source $VIMRUNTIME/defaults.vim
set termguicolors " activates bold syntax highlighting
set tabstop=4 " number of visual spaces per TAB
set softtabstop=4 " number of spaces in tab when editing
set shiftwidth=4 " number of spaces in one level of indentation
set expandtab " tabs are spaces
set number relativenumber " number " show line numbers
set showcmd " show command in bottom bar
set cursorline " highlight current line
set wildmenu " visual autocomplete for command menu
set incsearch " search as characters are entered
set hlsearch " highlight matches
set foldenable " enable folding
set foldmethod=syntax " enable method folding
let mapleader="," " set mapleader key
syntax enable " enable syntax processing
filetype indent on " load filetype-specific indent files
colorscheme nord " set colorscheme

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
    " nnoremap <CR> o<ESC>k
    nnoremap <CR> i<CR><ESC>k$
    vnoremap <CR> i<CR><ESC>k$
    nnoremap <TAB> i<TAB><ESC>l
    " inoremap jk <ESC>
" Leader keybindings
    nmap <leader>p "0p
    nmap <leader>P "0P
    nmap <leader>' ysiw'
    nmap <leader>" ysiw"
    nmap <leader>` ysiw`
    nmap <leader>< bi<<ESC>ea><ESC>
    nmap <leader>div ysiw<div>
" Move between Vimdows
"    nmap <space> <C-w>

