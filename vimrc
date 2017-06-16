" Automatic vim-plug installation if missing
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins with vim-plug manager
call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
Plug 'scrooloose/syntastic'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'Yggdroot/indentLine'
call plug#end()

" Theme config
colorscheme gruvbox
set background=dark

" Airline config
set laststatus=2
set ttimeoutlen=10
set noshowmode
let g:airline_theme='luna'
let g:airline_powerline_fonts = 1

" Gitgutter config
set updatetime=250
let g:gitgutter_sign_column_always = 1
"highlight clear SignColumn

" IndentLine config
let g:indentLine_enabled = 0
let g:indentLine_color_term = 239

" Reach last character in normal mode
set virtualedit+=onemore

" Display line numbers
set number
set cursorline
"highlight LineNr ctermfg=grey
"highlight CursorLine ctermbg=darkgrey
highlight CursorLineNr ctermfg=lightgrey

" Replace tab by spaces
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Max characters warning
augroup collumnLimit
    autocmd!
    autocmd BufEnter,WinEnter,FileType cpp
        \ highlight CollumnLimit ctermbg=Red guibg=Red
    let collumnLimit = 100 " feel free to customize
    let pattern =
        \ '\%<' . (collumnLimit+1) . 'v.\%>' . collumnLimit . 'v'
    autocmd BufEnter,WinEnter,FileType cpp
        \ let w:m1=matchadd('CollumnLimit', pattern, -1)
augroup END

" Searching
set incsearch
set hlsearch
nnoremap <silent><C-n> :noh<Enter>

" Folding
set foldenable
set foldlevelstart=1
set foldnestmax=1
set foldmethod=indent

" Mapping
nnoremap <F5> :w<Enter>
inoremap <F5> <Esc>:w<Enter>i
nnoremap <silent><F6> :IndentLinesToggle<Enter>
inoremap <silent><F6> <Esc>:IndentLinesToggle<Enter>
nnoremap <F8> :q<Enter>
inoremap <F8> <Esc>:q<Enter>

