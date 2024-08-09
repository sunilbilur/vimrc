" install vimplug if not installed
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    " setup nerdfonts, if it's the first run 
    silent execute '!mkdir -p ~/.local/share/fonts; 
        \curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/DroidSansMono/DroidSansMNerdFont-Regular.otf;
        \mv DroidSansMNerdFont-Regular.otf ~/.local/share/fonts; fc-cache -fv'
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs 
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | :qa
endif

" install plugins
if !empty(glob(data_dir."/autoload/plug.vim"))
call plug#begin()
    Plug 'preservim/nerdtree'
    Plug 'ryanoasis/vim-devicons'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    Plug 'Xuyuanp/nerdtree-git-plugin'

    Plug 'vim-airline/vim-airline'
    Plug 'gcavallanti/vim-noscrollbar'

    Plug 'easymotion/vim-easymotion'
    Plug 'justinmk/vim-sneak'
    Plug 'tpope/vim-surround'
    Plug 'jiangmiao/auto-pairs'
    
    Plug 'sheerun/vim-polyglot'
    Plug 'morhetz/gruvbox'
call plug#end()
endif

" nerdtree configuration
if !empty(glob(data_dir."/plugged/nerdtree"))
    " Start NERDTree and leave the cursor in it.
    autocmd VimEnter * NERDTree
    " Start NERDTree and put the cursor back in the other window.
    autocmd VimEnter * NERDTree | wincmd p
    " Start NERDTree when Vim is started without file arguments.
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
    " Start NERDTree. If a file is specified, move the cursor to its window.
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif
    " Exit Vim if NERDTree is the only window remaining in the only tab.
    autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
    " Close the tab if NERDTree is the only window remaining in it.
    autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
    " If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
    autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
    " Open the existing NERDTree on each new tab.
    autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif
    " remove 'Press ? for help'

    let NERDTreeMinimalUI=1
    nnoremap <C-n> :NERDTree<CR>
    nnoremap <C-t> :NERDTreeToggle<CR>
    nnoremap <C-f> :NERDTreeFind<CR>
endif


" airline configuration 
if !empty(glob(data_dir."/plugged/vim-airline"))
    let g:airline#extensions#tabline#enabled = 1
    if !empty(glob(data_dir."/plugged/vim-noscrollbar"))
        function! Noscrollbar(...)
            let w:airline_section_x = '%{noscrollbar#statusline(50,"-","#")}'
        endfunction
        call airline#add_statusline_func('Noscrollbar')
    endif
endif

" vim-sneak configuration
if !empty(glob(data_dir."/plugged/vim-sneak"))
    let g:sneak#label = 1
endif

" ====================================  vim configuration ====================================
syntax on
filetype plugin indent on
set encoding=UTF-8
set number
set shiftwidth=4
set tabstop=4
set expandtab
set mouse=a
set autoindent 
set smartindent
set clipboard=unnamed,unnamedplus
set incsearch
set hlsearch
set cursorline
set noswapfile


if !empty(glob(data_dir."/plugged/gruvbox"))
    colorscheme gruvbox
    set background=dark
endif

"disable continuation of comment characters
autocmd FileType * setlocal formatoptions-=cro

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" clear highlighting on escape in normal mode
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[
