" curl -L https://github.com/habamax/vimrc/tarball/master | tar xz --strip-components 1
filetype plugin indent on
syntax on

set hidden confirm
set fileformat=unix fileformats=unix,dos
set nohlsearch incsearch ignorecase
set tabstop=8 shiftwidth=4 expandtab smarttab shiftround
set autoindent copyindent preserveindent
set nostartofline
set ttimeout ttimeoutlen=0
set ruler
set showcmd shortmess+=Ic
set lazyredraw display=lastline
set completeopt=menu
set nowrap
set formatoptions=cqjl
set backspace=indent,eol,start
set nospell spelllang=en
set commentstring=
set sessionoptions=buffers,curdir,tabpages,winsize
set foldmethod=indent foldlevelstart=1
set wildmenu wildmode=longest:full,full wildcharm=<C-z>
set history=200


" Essential for my vimscripting
" run selected vimscript
xnoremap <silent> <space>v y:@"<cr>
" run vimscript line
nmap <space>vv V<space>v
" run operator
func! s:viml(...)
    if a:0 == 0
        let &opfunc = matchstr(expand('<sfile>'), '[^. ]*$')
        return 'g@'
    endif
    let commands = {"line": "'[V']y", "char": "`[v`]y", "block": "`[\<c-v>`]y"}
    silent exe 'noautocmd keepjumps normal! ' . get(commands, a:1, '')
    @"
endfunc
nnoremap <silent> <expr> <space>v <SID>viml()

set pastetoggle=<F11>

" Toggles
nnoremap <silent> yoh :set hlsearch! hlsearch?<CR>
nnoremap <silent> yow :set wrap! wrap?<CR>
nnoremap <silent> yon :set number! number?<CR>
nnoremap <silent> yor :set relativenumber! relativenumber?<CR>
nnoremap <silent> yol :set list! list?<CR>
nnoremap <silent> yos :set spell! spell?<CR>
nnoremap <silent> yoc :set cursorline! cursorline?<CR>
nnoremap <expr> yod (&diff ? ":diffoff" : ":diffthis").."<CR>"

" QuickFix
nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> ]Q :clast<CR>
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> [Q :cfirst<CR>
nnoremap <silent> ]w :lnext<CR>
nnoremap <silent> ]W :llast<CR>
nnoremap <silent> [w :lprevious<CR>
nnoremap <silent> [W :lfirst<CR>

" Sort operator
func! s:sort(type, ...)
    '[,']sort
endfunc
nmap <silent> gs :set opfunc=<SID>sort<CR>g@
xmap <silent> gs :sort<CR>


augroup filetypes | au!
    " sudo npm -g install js-beautify
    au Filetype json let &l:formatprg = "js-beautify -f -"
augroup END
