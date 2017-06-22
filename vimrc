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
Plug 'ervandew/supertab'
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
nnoremap <silent><C-n> :noh<CR>

" Folding
set foldenable
set foldlevelstart=1
set foldnestmax=1
set foldmethod=indent

" Mapping
nnoremap <F5> :w<CR>
inoremap <F5> <Esc><Right>:w<CR>i
nnoremap <silent><F6> :IndentLinesToggle<CR>
inoremap <silent><F6> <Esc>:IndentLinesToggle<CR>
nnoremap <F8> :q<CR>
inoremap <F8> <Esc>:q<CR>

" Automatic parenthesis/bracket/quotes closing
inoremap <silent>( <c-r>=OpenPair('(', ')')<CR>
inoremap <silent>{ <c-r>=OpenPair('{', '}')<CR>
inoremap <silent>[ <c-r>=OpenPair('[', ']')<CR>
autocmd FileType html,vim inoremap < <lt>><Left>

inoremap <silent>) <c-r>=ClosePair(')')<CR>
inoremap <silent>} <c-r>=ClosePair('}')<CR>
inoremap <silent>] <c-r>=ClosePair(']')<CR>
autocmd FileType html,vim inoremap <silent>> <c-r>=ClosePair('>')<CR>

inoremap <silent>" <c-r>=QuoteDelim('"')<CR>
inoremap <silent>' <c-r>=QuoteDelim("'")<CR>

function! OpenPair(char, opChar)
    if PairAllowed()
        return a:char.a:opChar."\<Left>"
    else
        return a:char
    endif
endf

function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endf

function! QuoteDelim(char)
    if PairAllowed() && NotInWord(a:char) && !(&ft=='vim' && a:char == '"')
        \ && getline('.')[col('.') - 2] != '\'
        return a:char.a:char."\<Left>"
    elseif getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endf

function! PairAllowed()
    if col('.') == col('$')
        return 1
    endif
    for char in [' ', ')', '}', ']']
        if getline('.')[col('.') - 1] == char
            return 1
        endif
    endfor
    return 0
endf

function! NotInWord(char)
    let prev_char = getline('.')[col('.') - 2]
    if a:char != "'" || col('$') == 1
        return 1
    endif
    if !(prev_char >= 'a' && prev_char <= 'z' 
        \ || prev_char >= 'A' && prev_char <= 'Z')
        return 1
    else
        return 0
    endif
endf

" Automatic double parenthesis/brackets/quotes removal
inoremap <silent><BS> <c-r>=BSCheck()<CR>

function! BSCheck()
    let leftC = ['(', '{', '[', '<', '"', "'"]
    let rightC = [')', '}', ']', '>', '"', "'"]
    let line = getline('.')
    let col = col('.')
    for i in [0, 1, 2, 3, 4, 5]
        if line[col - 2] == leftC[i] && line[col - 1] == rightC[i]
            return "\<Right>\<BS>\<BS>"
        endif
    endfor
    return "\<BS>"
endf

" Automatic indent between curly braces
inoremap <silent><CR> <c-r>=EnterCheck()<CR>

function! EnterCheck()
    let line = getline('.')
    if line[col('.') - 2] == '{' && line[col('.') - 1] == '}'
        return "\<CR>\<CR>\<Up>\<Tab>"
    else
        return "\<CR>"
    endif
endf

