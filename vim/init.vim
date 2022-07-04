set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

call plug#begin()
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }
Plug 'kyazdani42/nvim-web-devicons' " coloured icons
" Plug 'ryanoasis/vim-devicons' " non-colored icons
Plug 'jdhao/better-escape.vim' " no delay on jk when exiting insert mode
Plug 'tpope/vim-surround'
call plug#end()

" Installation: PlugInstall plugin.vim
