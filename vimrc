call plug#begin('~/.local/share/nvim/plugged')
  Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
  Plug 'mbbill/undotree'
  Plug 'dylanaraps/wal.vim'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-fugitive'
  Plug 'itchyny/lightline.vim'
  Plug 'tpope/vim-commentary'
  Plug 'jiangmiao/auto-pairs'
  Plug 'rakr/vim-one'
  Plug 'jceb/vim-orgmode'
  Plug 'easymotion/vim-easymotion'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'mrtazz/simplenote.vim'
  Plug 'godlygeek/tabular'
  Plug 'gabrielelana/vim-markdown'
  Plug 'kblin/vim-fountain'
  Plug 'mattn/emmet-vim'
  Plug 'rstacruz/vim-closer'
  Plug 'neomake/neomake'
  Plug 'junegunn/limelight.vim'
  Plug 'junegunn/goyo.vim'
call plug#end()

" Gui Settings

" Render HTML arguments such as class, id, data ... as italic
highlight htmlArg gui=italic
highlight htmlArg cterm=italic

" Render comments in italic
highlight Comment gui=italic
highlight Comment cterm=italic

" Colors
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors
set background=dark " for the dark version

" Color Scheme
let g:one_allow_italics = 1 " I love italic for comments<Paste>
colorscheme one

" set showtabline=2  " Show tabline
" set guioptions-=e  " Don't use GUI tabline

" Fundamental settings
set scrolloff=5
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,gbk,cp936,latin-1
set fileformat=unix
set fileformats=unix,dos,mac
filetype on
filetype plugin on
filetype plugin indent on
syntax on
set foldcolumn=2
set clipboard+=unnamedplus
set smartindent
set expandtab         "tab to spaces
set tabstop=8         "the width of a tab
set shiftwidth=8      "the width for indent
set foldenable
set foldmethod=indent "folding by indent
set foldlevel=80
set ignorecase        "ignore the case when search texts
set smartcase         "if searching text contains uppercase case will not be ignored
set linebreak
set number           "line number
set cursorline       "hilne
"night the line of the cursor
set autochdir


au FileType python setl sw=2 sts=2 et
au FileType html setl sw=2 sts=2 et

au BufNewFile,BufReadPost *.{md,mdown,mkd,mkdn,markdown,mdwn} set filetype=markdown
au FileType markdown setlocal textwidth=0
au FileType markdown setlocal showbreak=↳\
au FileType markdown setlocal linebreak
au FileType markdown setlocal nolist
au FileType markdown setlocal spell
au BufNewFile,BufReadPost,BufWrite *.{md,mdown,mkd,mkdn,markdown,mdwn} syntax match Comment /\%^---\_.\{-}---$/
let g:table_mode_corner="|"
" Set header folding level
let g:vim_markdown_folding_level = 1
" Set the number of spaces of indent
let g:vim_markdown_new_list_item_indent = 2
" Enable TOC window auto-fit
let g:vim_markdown_toc_autofit = 1
" Do not conceal [link text](link url) as just link text
let g:vim_markdown_conceal = 0
" Highlight YAML front matter as used by Jekyll or Hugo.
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_fenced_languages = ['csharp=cs', 'ruby=rb', 'vim=vim', 'bash=sh']


" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap <Leader>F <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

" NERDTree
map <C-n> :NERDTreeToggle<CR>


" Package Settings


let g:lightline = {
  \   'colorscheme': 'one',
  \   'active': {
  \     'left':[ [ 'mode', 'paste' ],
  \              [ 'gitbranch', 'readonly', 'filename', 'modified' ]
  \     ]
  \   },
	\   'component': {
	\     'lineinfo': ' %3l:%-2v',
	\   },
  \   'component_function': {
  \     'gitbranch': 'fugitive#head',
  \   }
  \ }
let g:lightline.separator = {
	\   'left': '', 'right': ''
  \}
let g:lightline.subseparator = {
	\   'left': '', 'right': '' 
  \}

let g:lightline.tabline = {
  \   'left': [ ['tabs'] ],
  \   'right': [ ['close'] ]
  \ }

" set showtabline=2  " Show tabline
" set guioptions-=e  " Don't use GUI tabline

" FZF
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:fzf_layout = { 'down': '~30%' }

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

let g:fzf_history_dir = '~/.local/share/fzf-history'

" Automake
call neomake#configure#automake('w')

let g:fzf_action = {
    \ 'ctrl-s': 'split',
    \ 'ctrl-v': 'vsplit'
    \ }
nnoremap <c-p> :FZF<cr>

let g:goyo_width = 80

function! s:goyo_enter()
  silent !tmux set status off
  silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  set noshowmode
  set noshowcmd
  set scrolloff=999
  Limelight
  set statusline=%f\ %m
  hi statusline ctermfg=white
endfunction

function! s:goyo_leave()
  silent !tmux set status on
  silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  set showmode
  set showcmd
  set scrolloff=5
  set background=dark
  Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" Use deoplete.
let g:deoplete#enable_at_startup = 1

" Auto-save files
function s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

" source ~/.simplenoterc

set t_Co=256
set t_8b=^[[48;2;%lu;%lu;%lum
set t_8f=^[[38;2;%lu;%lu;%lum

" Mappings
map j gj
map k gk

nnoremap ; :
vnoremap ; :
map ; :

nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>a

noremap! <C-BS> <C-w>
noremap! <C-h> <C-w>

imap <C-BS> <C-W>
