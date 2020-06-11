set nocompatible
filetype off

filetype plugin indent on

" Setting up Vundle - the vim plugin bundler
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle.."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    let iCanHazVundle=0
endif

" configuration of 'standard'. TODO: uncomment below once we are enforcing it.
" let g:syntastic_javascript_checkers = ['standard']
" autocmd bufwritepost *.js silent !standard --fix %
" set autoread

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" plugins. User PluginInstall command to install them
Plugin 'gmarik/Vundle.vim'
Plugin 'vifm/vifm.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-sensible'
Plugin 'slim-template/vim-slim'
Plugin 'chriskempson/base16-vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'taylor/vim-zoomwin'
Plugin 'terryma/vim-expand-region'
Plugin 'vim-scripts/gitignore'
Plugin 'jiangmiao/auto-pairs'
Plugin 'vim-syntastic/syntastic'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-cucumber'
Plugin 'vimwiki/vimwiki'
Plugin 'itchyny/calendar.vim'
" Bundle 'wookiehangover/jshint.vim' " causes misbehaviour with space+w

if iCanHazVundle == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :BundleInstall
endif
" Setting up Vundle - the vim plugin bundler end

syntax on
filetype plugin indent on
syntax enable
" solarized configuration
"let base16colorspace=256
"let g:solarized_termcolors=256
"set background=light
"colorscheme solarized
"call togglebg#map("<F5>")

let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_theme='angr'
let g:airline#extensions#tabline#enabled = 1

set tabstop=2
set shiftwidth=2
set expandtab
set clipboard=unnamed
set ttyfast
let mapleader = "\<Space>"
nnoremap <Leader>w :w<CR>
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P
nmap =j :%!python -m json.tool<CR>
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)
nnoremap <Leader>d :bdel<CR>
nnoremap <Leader>n :split<CR>
nnoremap <Leader>v :vsplit<CR>
nnoremap <Leader>m :Vifm<CR>
let g:ctrlp_use_caching = 0
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
    \ }
endif

map <C-l> 5<C-w>>
map <C-h> 5<C-w><
map <C-j> 3<C-w>+
map <C-k> 3<C-w>-
map <leader><leader> :ZoomWin<cr>
set t_Co=256

" Strip trailing whitespace
function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" show tabs
set list
set listchars=tab:>-,trail:~,extends:>,precedes:<

set number

let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|app-cov'
" VimWiki
let wiki_1 = {}
let wiki_1.path = '~/vimwiki/'
let wiki_1.syntax = 'markdown'
let wiki_1.ext = '.md'

let g:vimwiki_list = [wiki_1]
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}

" VimWiki calendar hook
autocmd FileType calendar nmap <buffer> <CR> :<C-u>call vimwiki#diary#calendar_action(b:calendar.day().get_day(), b:calendar.day().get_month(), b:calendar.day().get_year(), b:calendar.day().week(), "V")<CR>

" Calendar
let g:calendar_google_calendar = 1
let g:calendar_google_task = 1
let g:calendar_first_day = 'monday'
