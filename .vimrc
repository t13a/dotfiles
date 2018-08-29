" Plugins
set nocompatible
filetype off
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'guns/xterm-color-table.vim'
Plugin 'itchyny/vim-gitbranch' " for itchyny/lightline.vim
Plugin 'jamessan/vim-gnupg'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'tmux-plugins/vim-tmux-focus-events'
Plugin 'tomasr/molokai'
Plugin 'vim-scripts/fcitx.vim'
if has('gui_running') || !empty($DISPLAY) && &t_Co >= 256
    Plugin 'itchyny/lightline.vim'
    let g:lightline = {
        \ 'colorscheme': 'powerline',
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ],
        \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
        \ },
        \ 'component_function': {
        \   'gitbranch': 'gitbranch#name'
        \ },
        \ }
    set noshowmode " for lightline
endif
call vundle#end()
filetype plugin indent on

" Neovim has set these as default
if !has('nvim')
    set autoindent
    set autoread
    set backspace=indent,eol,start
    set complete-=i
    set display=lastline
    set encoding=utf-8
    set history=10000
    set hlsearch
    set incsearch
    set laststatus=2
    set mouse=a
    set smarttab
    set ttyfast
    set ttymouse=xterm2
    set viminfo+=!
    set wildmenu
    syntax on
endif

" Color
if has('gui_running') || !empty($DISPLAY) && &t_Co >= 256
    set background=dark
    colorscheme molokai
    highlight MatchParen ctermfg=208 ctermbg=NONE guifg=#FD971F guibg=NONE

    " Same as GUI
    highlight Comment ctermfg=244
    highlight CursorLine ctermbg=237
    highlight Delimiter ctermfg=244
    highlight LineNr ctermfg=240 ctermbg=235
    highlight Normal ctermfg=255 ctermbg=234
    highlight Search ctermfg=232
    highlight Visual ctermbg=237

    " Same as terminal
    highlight Cursor guifg=NONE guibg=NONE gui=reverse
endif

" Hilight extra whitespace & tab character
" ref: http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=red guibg=red
" highlight TabCharacter ctermbg=236 guibg=#3B3A32
match ExtraWhitespace /\s\+$/
" match TabCharacter /\t/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
" autocmd BufWinEnter * match TabCharacter /\t/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
" autocmd InsertEnter * match TabCharacter /\t/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
" autocmd InsertLeave * match TabCharacter /\t/
autocmd BufWinLeave * call clearmatches()

" Highlight confusing characters
"
"      3000: Ideographic space
" FF01-FF5E: Fullwidth ASCII variants
" FF65-FF9F: Halfwidth Katakana variants
" FFE0-FFE6: Fullwidth symbol variants
" FFE8-FFEE: Halfwidth symbol variants
autocmd BufRead,BufNew * match ConfusingCharacters /[\u3000\uff01-\uff5e\uff65-\uff9f\uffe0-\uffe6\uffe8-\uffee]/
highlight ConfusingCharacters ctermfg=black ctermbg=darkgreen guifg=black guibg=darkgreen

" ref: https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/149214
autocmd FocusGained,BufEnter * :checktime

" Move cursor by screen line
:noremap <Up> gk
:noremap <Down> gj
:noremap <Home> g0
:noremap <End> g$
" workaround for fcitx
" :noremap! <Up> <C-O>gk
" :noremap! <Down> <C-O>gj
" :noremap! <Home> <C-O>g0
" :noremap! <End> <C-O>g$

" Indentation
filetype indent off
set expandtab
set shiftwidth=2
" set smartindent
set tabstop=2

" Search
set ignorecase
set smartcase

" Clipboard
if has('gui_running') || !empty($DISPLAY)
    autocmd VimLeave * call system("xsel -ib", getreg()) " remain after exit
    set clipboard=unnamedplus
endif

" Search for visually selected text
" ref: http://vim.wikia.com/wiki/Search_for_visually_selected_text
vnoremap // y/\V<C-r>=escape(@",'/\')<CR><CR>

" Miscellaneous
let g:GPGPreferArmor=1
let NERDSpaceDelims=1
let NERDTreeShowHidden=1
map <Leader>nb :NERDTreeFromBookmark
map <Leader>nf :NERDTreeFind<CR>
map <Leader>nn :NERDTreeToggle<CR>
set ambiwidth=double
set listchars=eol:$,tab:>-
set nobackup
set nojoinspaces
set noswapfile
set number
set showmatch
set ttimeoutlen=100 " for fcitx
set updatetime=100 " for vim-gitgutter
set whichwrap+=<,>,[,]
