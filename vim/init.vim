set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

call plug#begin()
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " syntax parser
    Plug 'jdhao/better-escape.vim' " no delay on jk when exiting insert mode
    Plug 'tpope/vim-surround' " useful for indentation inside {} [] () <>
    Plug 'kyazdani42/nvim-web-devicons' " colored file icons
    Plug 'kyazdani42/nvim-tree.lua' " file explorer
call plug#end()

" Installation: PlugInstall plugin.vim
