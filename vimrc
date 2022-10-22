" Defaults for all files
set shiftwidth=4
set autoindent
set autowrite
set ignorecase
set incsearch
" set showmatch
set expandtab
set smarttab
set softtabstop=4
set ruler
set hlsearch
set visualbell

set statusline=%f[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %o
set laststatus=2

" au FileType python source ~/vim/scripts/python.vim

cabbr vds vertical diffsplit
cabbr vsb vertical sbuffer

map X :Exp<CR>
map <Tab> <C-W>w
map <S-Tab> <C-W>W
map <F2> :cp<CR>
map <F3> :cn<CR>
map <F4> :cclose<CR>
map <leader>5 :lopen<CR>
map <leader>2 :lprev<CR>
map <leader>3 :lnext<CR>
map <leader>4 :lclose<CR>
set pastetoggle=<F5>

set diffopt=filler,context:15,iwhite

" Tell vim that my terminal uses a dark background
set background=dark
set guioptions-=T

" Prettier for js/hmtl/json and such
let g:prettier#autoformat_config = 1
let g:prettier#autoformat_require_pragma = 0

let g:ale_fixers = {
\    'javascript': ['prettier', 'eslint'],
\}
let g:ale_fix_on_save = 1
let g:ale_linters = {
\    'go': ['gofmt', 'staticcheck', 'gopls', 'govet'],
\}

" Note: prettier seems to suck. tidy works better?
map <leader>t :%!tidy -i -q<CR>

syntax on
filetype on				" enable special filetype things
filetype indent on			" bbawn: needed for html indent?

" Special configuration for special types of files ...
autocmd FileType xml,html		setlocal si expandtab sw=2
autocmd FileType css		        setlocal si expandtab sw=2
autocmd FileType javascript             setlocal expandtab sw=2 tw=78
autocmd FileType Makefile,makefile	setlocal noexpandtab tw=78
autocmd FileType c,cpp,java     	setlocal formatoptions=tcrq cindent comments=sr:/*,mb:*,ex:*/,:// tw=78 cino=:0
autocmd FileType perl     		setlocal formatoptions=tcrq cindent cinkeys=0{,0},0),:,!^F,o,O,e tw=78
autocmd FileType python	setlocal expandtab
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType python nmap <leader>P :w\|!python %

autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 
autocmd FileType go nmap <leader>a  :GoAlternate<CR>
autocmd FileType go nmap <leader>A  :GoAutoTypeInfoToggle<CR>
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>d  <Plug>(go-def)
autocmd FileType go nmap <leader>D  <Plug>(go-doc)
autocmd FileType go nmap <leader>r  :GoReferrers<CR>
autocmd FileType go nmap <leader>R  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)
autocmd FileType go nmap <leader>C  <Plug>(go-coverage-toggle)
autocmd FileType go nmap <leader>I  <Plug>(go-imports)
autocmd FileType go nmap <Leader>i  <Plug>(go-info)
autocmd FileType go nmap <Leader>f  <Plug>(go-callers)
autocmd FileType go nmap <Leader>F  <Plug>(go-callees)
autocmd FileType go nmap <Leader>n  <Plug>(go-rename)
autocmd FileType go nmap <Leader>v  <Plug>(go-def-vertical)
autocmd FileType go nmap <Leader>s  <Plug>(go-def-split)
autocmd FileType go nmap <Leader>r  <Plug>(go-referrers)
autocmd FileType go nmap <Leader>x  <Plug>(go-implements)

autocmd FileType go setlocal omnifunc=v:lua.vim.lsp.omnifunc

let g:go_list_type = "quickfix"
" if guru definition tag is too slow...
" let g:go_def_mode = 'godef'
let g:go_def_mode = 'gopls'
let g:go_info_mode = 'gopls'

" call plug#begin()
" Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
" Plug 'ctrlpvim/ctrlp.vim'
" call plug#end()

" vim-go is broken, this supposedly helps
set nocompatible
set shell=/bin/sh
syntax on
filetype plugin on
let g:go_disable_autoinstall = 0

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
endif

" grep word under cursor
nnoremap <leader>g :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

nnoremap <leader>0 :set nonu<CR>
nnoremap <leader>1 :set nu<CR>
nnoremap <leader>c :%s/\e\[[0-9;]*[mABFGHK]//g<CR>
nnoremap <leader>m :%s/\r//g<CR>
nnoremap <leader>N :e ~/Documents/notes<CR>
nnoremap <leader>( :DoMatchParen<CR>
nnoremap <leader>) :NoMatchParen<CR>

" Define common tabularizations
" XXX can't get these to work
if exists(":Tabularize")
  nmap <Leader>z= :Tabularize /=<CR>
  vmap <Leader>z= :Tabularize /=<CR>
  nmap <Leader>z: :Tabularize /:\zs<CR>
  vmap <Leader>z: :Tabularize /:\zs<CR>
  nmap <Leader>z, :Tabularize /,\zs<CR>
  vmap <Leader>z, :Tabularize /,\zs<CR>
endif

" TODO Probably put these in after insert too like cucumber
" Tabularize cucumber after insert
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

" Map omnifunc completion to easier key
inoremap <F8> <C-X><C-O>

" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL

