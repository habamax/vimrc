" curl -LO https://raw.githubusercontent.com/habamax/vimrc/master/.vimrc
filetype plugin indent on
syntax on

set hidden confirm
set nohlsearch incsearch ignorecase
set shiftwidth=4 softtabstop=-1 expandtab
set autoindent
set nostartofline virtualedit=block
set ttimeout ttimeoutlen=0
set ruler
set shortmess+=Ic
set lazyredraw display=lastline
set completeopt=menu
set nowrap
set formatoptions=cqjl
set backspace=indent,eol,start
set nospell spelllang=en
set commentstring=
set foldmethod=indent foldlevelstart=1 foldminlines=2
set wildmenu
set sessionoptions=buffers,curdir,tabpages,winsize
set history=200


set pastetoggle=<F12>

" Toggles
nnoremap <silent> yoh :set hlsearch! hlsearch?<CR>
nnoremap <silent> yow :set wrap! wrap?<CR>
nnoremap <silent> yon :set number! number?<CR>
nnoremap <silent> yor :set relativenumber! relativenumber?<CR>
nnoremap <silent> yol :set list! list?<CR>
nnoremap <silent> yos :set spell! spell?<CR>
nnoremap <silent> yoc :set cursorline! cursorline?<CR>
nnoremap <expr> yod (&diff ? ":diffoff" : ":diffthis") . "<CR>"

" QuickFix
nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> ]Q :clast<CR>
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> [Q :cfirst<CR>
nnoremap <silent> ]w :lnext<CR>
nnoremap <silent> ]W :llast<CR>
nnoremap <silent> [w :lprevious<CR>
nnoremap <silent> [W :lfirst<CR>

" Windows
nnoremap <silent> <C-w>m :resize<bar>vert resize<CR>
nmap <C-w><C-m> <C-w>m
nnoremap <silent><expr> <C-j> winnr('$') > 1 ? "\<C-w>w" : ":bel vs +b#\<CR>"
nnoremap <silent><expr> <C-k> winnr('$') > 1 ? "\<C-w>W" : ":vs +b#\<CR>"

" Buffers
nnoremap <silent> <C-n> :bn<CR>
nnoremap <silent> <C-p> :bp<CR>

" Comment things
func! s:comment(...)
    if a:0 == 0
        let &opfunc = matchstr(expand('<sfile>'), '[^. ]*$')
        return 'g@'
    endif
    if empty(&cms) | return | endif
    let cms = substitute(substitute(&cms, '\S\zs%s\s*', ' %s', ''), '%s\ze\S', '%s ', '')
    let [lnum1, lnum2] = [line("'["), line("']")]
    let cms_l = split(escape(cms, '*.'), '%s')
    if len(cms_l) == 0 | return | endif
    if len(cms_l) == 1 | call add(cms_l, '') | endif
    let comment = 0
    let indent_min = indent(lnum1)
    let indent_start = matchstr(getline(lnum1), '^\s*')
    for lnum in range(lnum1, lnum2)
        if getline(lnum) =~ '^\s*$' | continue | endif
        if indent_min > indent(lnum)
            let indent_min = indent(lnum)
            let indent_start = matchstr(getline(lnum), '^\s*')
        endif
        if getline(lnum) !~ '^\s*' . cms_l[0] . '.*' . cms_l[1] . '$'
            let comment = 1
        endif
    endfor
    let lines = []
    for lnum in range(lnum1, lnum2)
        if getline(lnum) =~ '^\s*$'
            let line = getline(lnum)
        elseif comment
            if exists("g:comment_first_col") || exists("b:comment_first_col")
                let line = printf(cms, getline(lnum))
            else
                let line = printf(indent_start . cms, strpart(getline(lnum), strlen(indent_start)))
            endif
        else
            let line = substitute(getline(lnum), '^\s*\zs'.cms_l[0].'\|'.cms_l[1].'$', '', 'g')
        endif
        call add(lines, line)
    endfor
    noautocmd keepjumps call setline(lnum1, lines)
endfunc
nnoremap <silent> <expr> gc <SID>comment()
xnoremap <silent> <expr> gc <SID>comment()
nnoremap <silent> <expr> gcc <SID>comment() . '_'


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


func! s:redir(cmd) abort
    for win in range(1, winnr('$'))
        if getwinvar(win, 'scratch')
            execute win . 'windo close'
        endif
    endfor
    if version > 704
        let output = split(execute(a:cmd), "\n")
    else
        redir => out
        exe a:cmd
        redir END
        let output = split(out, "\n")
    endif
    vnew
    let w:scratch = 1
    setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
    call setline(1, output)
endfunc
command! -nargs=1 -complete=command Redir silent call s:redir(<q-args>)


augroup filetypes | au!
    " sudo npm -g install js-beautify
    au Filetype json let &l:formatprg = "js-beautify -f -"
    au Filetype html let &l:formatprg = "html-beautify -f -"
augroup END


" Swap & Backup & Undo
let &directory = expand('~/.vimdata/swap//')
let &backupdir = expand('~/.vimdata/backup//')
let &undodir = expand('~/.vimdata/undo//')
if !isdirectory(&undodir)   | call mkdir(&undodir, "p")   | endif
if !isdirectory(&backupdir) | call mkdir(&backupdir, "p") | endif
if !isdirectory(&directory) | call mkdir(&directory, "p") | endif
set backup
set undofile


if executable('rg') | set grepprg=rg\ --vimgrep grepformat=%f:%l:%c:%m | endif


" Embedded habamax colors
if exists('&t_Co') && &t_Co < 256 | finish | endif
set background=dark
hi clear
hi EndOfBuffer ctermfg=241 ctermbg=NONE cterm=NONE
hi Statusline ctermfg=235 ctermbg=246 cterm=NONE
hi StatuslineNC ctermfg=235 ctermbg=241 cterm=NONE
hi StatuslineTerm ctermfg=235 ctermbg=246 cterm=NONE
hi StatuslineTermNC ctermfg=246 ctermbg=241 cterm=NONE
hi VertSplit ctermfg=241 ctermbg=241 cterm=NONE
hi TabLine ctermfg=NONE ctermbg=241 cterm=NONE
hi TabLineFill ctermfg=NONE ctermbg=241 cterm=NONE
hi TabLineSel ctermfg=NONE ctermbg=NONE cterm=NONE
hi ToolbarLine ctermfg=NONE ctermbg=NONE cterm=NONE
hi ToolbarButton ctermfg=235 ctermbg=108 cterm=NONE
hi NonText ctermfg=241 ctermbg=NONE cterm=NONE
hi SpecialKey ctermfg=241 ctermbg=NONE cterm=NONE
hi Folded ctermfg=246 ctermbg=NONE cterm=underline
hi Visual ctermfg=235 ctermbg=110 cterm=NONE
hi VisualNOS ctermfg=235 ctermbg=110 cterm=NONE
hi LineNr ctermfg=246 ctermbg=NONE cterm=NONE
hi FoldColumn ctermfg=246 ctermbg=NONE cterm=NONE
hi CursorLine ctermfg=NONE ctermbg=234 cterm=NONE
hi CursorColumn ctermfg=NONE ctermbg=234 cterm=NONE
hi CursorLineNr ctermfg=NONE ctermbg=234 cterm=NONE
hi QuickFixLine ctermfg=NONE ctermbg=234 cterm=NONE
hi Pmenu ctermfg=NONE ctermbg=234 cterm=NONE
hi PmenuThumb ctermfg=NONE ctermbg=246 cterm=NONE
hi ColorColumn ctermfg=NONE ctermbg=234 cterm=NONE
hi DiffChange ctermfg=NONE ctermbg=237 cterm=NONE
hi DiffAdd ctermfg=NONE ctermbg=NONE cterm=NONE
hi DiffText ctermfg=109 ctermbg=67 cterm=NONE
hi DiffDelete ctermfg=173 ctermbg=NONE cterm=NONE
hi PmenuSbar ctermfg=NONE ctermbg=NONE cterm=NONE
hi PmenuSel ctermfg=235 ctermbg=144 cterm=NONE
hi SignColumn ctermfg=NONE ctermbg=NONE cterm=NONE
hi Error ctermfg=167 ctermbg=235 cterm=reverse
hi ErrorMsg ctermfg=167 ctermbg=235 cterm=reverse
hi ModeMsg ctermfg=235 ctermbg=186 cterm=NONE
hi WarningMsg ctermfg=144 ctermbg=NONE cterm=NONE
hi MoreMsg ctermfg=108 ctermbg=NONE cterm=NONE
hi Question ctermfg=173 ctermbg=NONE cterm=NONE
hi Todo ctermfg=186 ctermbg=235 cterm=reverse
hi MatchParen ctermfg=NONE ctermbg=NONE cterm=reverse
hi Search ctermfg=235 ctermbg=108 cterm=NONE
hi IncSearch ctermfg=235 ctermbg=186 cterm=NONE
hi WildMenu ctermfg=235 ctermbg=186 cterm=NONE
hi SpellBad ctermfg=167 ctermbg=NONE cterm=underline
hi SpellCap ctermfg=173 ctermbg=NONE cterm=underline
hi SpellLocal ctermfg=182 ctermbg=NONE cterm=underline
hi SpellRare ctermfg=186 ctermbg=NONE cterm=underline
hi! link Terminal Normal
hi! link LineNrAbove LineNr
hi! link LineNrBelow LineNr
hi Comment ctermfg=241 ctermbg=NONE cterm=NONE
hi Constant ctermfg=173 ctermbg=NONE cterm=NONE
hi String ctermfg=108 ctermbg=NONE cterm=NONE
hi Character ctermfg=151 ctermbg=NONE cterm=NONE
hi Identifier ctermfg=109 ctermbg=NONE cterm=NONE
hi Statement ctermfg=144 ctermbg=NONE cterm=NONE
hi PreProc ctermfg=67 ctermbg=NONE cterm=NONE
hi Type ctermfg=139 ctermbg=NONE cterm=NONE
hi Special ctermfg=66 ctermbg=NONE cterm=NONE
hi Underlined ctermfg=110 ctermbg=NONE cterm=underline
hi Title ctermfg=255 ctermbg=NONE cterm=bold
hi Directory ctermfg=67 ctermbg=NONE cterm=bold
hi Conceal ctermfg=246 ctermbg=NONE cterm=NONE
hi Ignore ctermfg=NONE ctermbg=NONE cterm=NONE
