" curl -LO https://raw.githubusercontent.com/habamax/vimrc/master/.vimrc
filetype plugin indent on
syntax on

set hidden confirm
set fileformat=unix fileformats=unix,dos
set nohlsearch incsearch ignorecase
set tabstop=8 shiftwidth=4 expandtab smarttab shiftround
set autoindent
set nostartofline virtualedit=block
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
set foldmethod=indent foldlevelstart=1
set wildmenu
set sessionoptions=buffers,curdir,tabpages,winsize
set history=200


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

" Better previous window
nnoremap <silent> <BS> <C-w>w

nnoremap <BS> <C-^>

" Run vimscript operator
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
xnoremap <silent> <space>v y:@"<cr>
nmap <space>vv V<space>v


augroup filetypes | au!
    " sudo npm -g install js-beautify
    au Filetype json let &l:formatprg = "js-beautify -f -"
    au Filetype html let &l:formatprg = "html-beautify -f -"
augroup END


" Swap & Backup & Undo
let &directory = expand('~/.vimdata/swap//')

set backup
let &backupdir = expand('~/.vimdata/backup//')

set undofile
let &undodir = expand('~/.vimdata/undo//')

if !isdirectory(&undodir)   | call mkdir(&undodir, "p")   | endif
if !isdirectory(&backupdir) | call mkdir(&backupdir, "p") | endif
if !isdirectory(&directory) | call mkdir(&directory, "p") | endif


" Embedded bronzage colors
set background=dark
hi clear
hi EndOfBuffer ctermfg=239 ctermbg=NONE cterm=NONE
hi Statusline ctermfg=237 ctermbg=244 cterm=NONE
hi StatuslineNC ctermfg=244 ctermbg=239 cterm=NONE
hi StatuslineTerm ctermfg=237 ctermbg=244 cterm=NONE
hi StatuslineTermNC ctermfg=244 ctermbg=239 cterm=NONE
hi VertSplit ctermfg=239 ctermbg=239 cterm=NONE
hi Pmenu ctermfg=NONE ctermbg=239 cterm=NONE
hi PmenuSel ctermfg=237 ctermbg=186 cterm=NONE
hi PmenuSbar ctermfg=NONE ctermbg=244 cterm=NONE
hi PmenuThumb ctermfg=NONE ctermbg=254 cterm=NONE
hi TabLine ctermfg=244 ctermbg=239 cterm=NONE
hi TabLineFill ctermfg=109 ctermbg=239 cterm=NONE
hi TabLineSel ctermfg=237 ctermbg=244 cterm=NONE
hi ToolbarLine ctermfg=NONE ctermbg=236 cterm=NONE
hi ToolbarButton ctermfg=237 ctermbg=108 cterm=NONE
hi NonText ctermfg=239 ctermbg=NONE cterm=NONE
hi SpecialKey ctermfg=239 ctermbg=NONE cterm=NONE
hi Folded ctermfg=244 ctermbg=236 cterm=NONE
hi Visual ctermfg=237 ctermbg=110 cterm=NONE
hi VisualNOS ctermfg=237 ctermbg=110 cterm=NONE
hi LineNr ctermfg=244 ctermbg=NONE cterm=NONE
hi FoldColumn ctermfg=244 ctermbg=NONE cterm=NONE
hi CursorLine ctermfg=NONE ctermbg=236 cterm=NONE
hi CursorColumn ctermfg=NONE ctermbg=236 cterm=NONE
hi CursorLineNr ctermfg=NONE ctermbg=236 cterm=NONE
hi QuickFixLine ctermfg=NONE ctermbg=236 cterm=NONE
hi SignColumn ctermfg=NONE ctermbg=237 cterm=NONE
hi Underlined ctermfg=186 ctermbg=NONE cterm=underline
hi Error ctermfg=167 ctermbg=NONE cterm=NONE
hi ErrorMsg ctermfg=167 ctermbg=NONE cterm=NONE
hi ModeMsg ctermfg=237 ctermbg=143 cterm=NONE
hi WarningMsg ctermfg=143 ctermbg=NONE cterm=NONE
hi MoreMsg ctermfg=108 ctermbg=NONE cterm=NONE
hi Question ctermfg=173 ctermbg=NONE cterm=NONE
hi Todo ctermfg=237 ctermbg=244 cterm=NONE
hi MatchParen ctermfg=236 ctermbg=143 cterm=NONE
hi Search ctermfg=236 ctermbg=108 cterm=NONE
hi IncSearch ctermfg=236 ctermbg=186 cterm=NONE
hi WildMenu ctermfg=237 ctermbg=186 cterm=NONE
hi ColorColumn ctermfg=NONE ctermbg=236 cterm=NONE
hi Cursor ctermfg=237 ctermbg=252 cterm=NONE
hi lCursor ctermfg=237 ctermbg=167 cterm=NONE
hi DiffAdd ctermfg=NONE ctermbg=NONE cterm=NONE
hi DiffChange ctermfg=NONE ctermbg=NONE cterm=NONE
hi DiffText ctermfg=237 ctermbg=143 cterm=NONE
hi DiffDelete ctermfg=137 ctermbg=NONE cterm=NONE
hi SpellBad ctermfg=167 ctermbg=NONE cterm=underline
hi SpellCap ctermfg=173 ctermbg=NONE cterm=underline
hi SpellLocal ctermfg=143 ctermbg=NONE cterm=underline
hi SpellRare ctermfg=186 ctermbg=NONE cterm=underline
hi Comment ctermfg=244 ctermbg=NONE cterm=NONE
hi Identifier ctermfg=143 ctermbg=NONE cterm=NONE
hi Function ctermfg=186 ctermbg=NONE cterm=NONE
hi Statement ctermfg=179 ctermbg=NONE cterm=NONE
hi Constant ctermfg=173 ctermbg=NONE cterm=NONE
hi String ctermfg=108 ctermbg=NONE cterm=NONE
hi Character ctermfg=107 ctermbg=NONE cterm=NONE
hi PreProc ctermfg=109 ctermbg=NONE cterm=NONE
hi Type ctermfg=137 ctermbg=NONE cterm=NONE
hi Special ctermfg=66 ctermbg=NONE cterm=NONE
hi SpecialChar ctermfg=137 ctermbg=NONE cterm=NONE
hi Tag ctermfg=116 ctermbg=NONE cterm=NONE
hi SpecialComment ctermfg=116 ctermbg=NONE cterm=NONE
hi Directory ctermfg=137 ctermbg=NONE cterm=bold
hi Conceal ctermfg=244 ctermbg=NONE cterm=NONE
hi Ignore ctermfg=NONE ctermbg=NONE cterm=NONE
hi Title ctermfg=254 ctermbg=NONE cterm=bold
