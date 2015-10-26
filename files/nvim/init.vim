"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   Plugins!
"                            Managed with vim-plug
"                     https://github.com/junegunn/vim-plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin()

Plug 'Lokaltog/vim-easymotion',      { 'on': '<Plug>(easymotion-s)' }
Plug 'MarcWeber/vim-addon-local-vimrc'
Plug 'SirVer/ultisnips'
Plug 'Valloric/YouCompleteMe',       { 'do': './install.py --clang-completer' }
Plug 'ashisha/image.vim',            { 'on': 'Image' }
Plug 'gorodinskiy/vim-coloresque'
Plug 'gregsexton/MatchTag',          { 'for': 'html' }
Plug 'honza/vim-snippets'
Plug 'janko-m/vim-test'
Plug 'jelera/vim-javascript-syntax', { 'for': 'javascript' }
Plug 'junegunn/fzf',                 { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'junegunn/vim-easy-align',      { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
Plug 'kchmck/vim-coffee-script',     { 'for': 'coffee' }
Plug 'mbbill/undotree',              { 'on': 'UndotreeToggle'   }
Plug 'morhetz/gruvbox'
Plug 'ntpeters/vim-better-whitespace'
Plug 'othree/html5.vim',             { 'for': 'html' }
Plug 'pangloss/vim-javascript',      { 'for': 'javascript' } " May try javascript_enable_domhtmlcss later
Plug 'rking/ag.vim',                 { 'on': 'Ag' }
Plug 'scrooloose/nerdtree',          { 'on': [ 'NERDTreeToggle', 'NERDTreeFind' ] }
Plug 'scrooloose/syntastic'
Plug 'slim-template/vim-slim',       { 'for': 'slim' }
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'troydm/zoomwintab.vim',        { 'on': 'ZoomWinTabToggle' }
Plug 'vim-ruby/vim-ruby',            { 'for': 'ruby' }

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 Vim Behavior
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set hidden                                                " don't unload buffer when switching away
set modeline                                              " allow per-file settings via modeline
set secure                                                " disable unsafe commands in local .vimrc files
set encoding=utf-8 fileencoding=utf-8 termencoding=utf-8  " saving and encoding
set nobackup nowritebackup noswapfile autoread            " no backup or swap
set hlsearch incsearch ignorecase smartcase               " search
set wildmenu                                              " completion
set backspace=indent,eol,start                            " sane backspace
set clipboard+=unnamed,unnamedplus                        " use the system clipboard for yank/put/delete
set mouse=a                                               " enable mouse for all modes settings
set nomousehide                                           " don't hide the mouse cursor while typing
set mousemodel=popup                                      " right-click pops up context menu
set ruler                                                 " show cursor position in status bar
set number                                                " show absolute line number of the current line
set nofoldenable                                          " I fucking hate code folding
set scrolloff=10                                          " scroll the window so we can always see 10 lines around the cursor
set textwidth=80                                          " wrap at 80 characters like a valid human
set printoptions=paper:letter                             " use letter as the print output format
set guioptions-=T                                         " turn off GUI toolbar (icons)
set guioptions-=r                                         " turn off GUI right scrollbar
set guioptions-=L                                         " turn off GUI left scrollbar
set winaltkeys=no                                         " turn off stupid fucking alt shortcuts
set laststatus=2                                          " always show status bar
set shell=bash

" check the parent directories for tags, too.
set tags=./tags,tags;$HOME

" middle-click paste
noremap! <s-insert> <middlemouse>

" auto save
autocmd BufLeave,CursorHold,CursorHoldI,FocusLost * silent! wa

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  Appearance
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax on
set background=dark
set t_Co=256 " 256 colors in terminal

if has('gui_gnome')
  set guifont=Ubuntu\ Mono\ 8.4
endif

" Neovim
" let $NVIM_TUI_ENABLE_TRUE_COLOR=1 " not yet supported in iTerm 2 stable
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" Tweaks for Molokai colorscheme (ignored if Molokai isn't used)
let g:molokai_original=1
let g:rehash256=1

" Use the first available colorscheme in this list
for scheme in [ 'gruvbox', 'solarized', 'molokai', 'desert' ]
  try
    execute 'colorscheme '.scheme
    break
  catch
    continue
  endtry
endfor

" highlight the 80th column
"
" In Vim >= 7.3, also highlight columns 120+
if exists('+colorcolumn')
  " (I picked 120-320 because you have to provide an upper bound and 500 seems
  " to be enough.)
  let &colorcolumn="80,".join(range(120,500),",")
else
  " fallback for Vim < v7.3
  autocmd BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  Formatting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype plugin indent on
set shiftwidth=2 tabstop=2 softtabstop=2 expandtab autoindent
autocmd filetype c,asm,python setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType make setlocal noexpandtab

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Plugin Configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" fugitive shortcuts
noremap \gs :Gstatus<cr>
noremap \gc :Gcommit<cr>
noremap \ga :Gwrite<cr>
noremap \gl :Glog<cr>
noremap \gd :Gdiff<cr>
noremap \gb :Gblame<cr>

" NERDTree
let NERDTreeWinPos='right'
noremap <c-\> :NERDTreeToggle<cr>
noremap \nf :NERDTreeFind<cr>

" EasyMotion
nmap <space> <Plug>(easymotion-s)

" UltiSnips
let g:UltiSnipsExpandTrigger = "<c-j>"

" ctrlp
" let g:ctrlp_working_path_mode = 'c'

" FZF
nmap <c-p> :FZF<cr>

" vim-easy-align
"" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

"" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" vim-test
nmap <silent> <leader>tt :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tv :TestVisit<CR>
let test#strategy = 'dispatch'

" Don't prompt to load ycm_extra_conf.py for YouCompleteMe; just load it.
let g:ycm_confirm_extra_conf = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use single quote as additional range key
noremap ' `

" Rerun previous :command
noremap \' @:

" Underline a line with hyphens (<h2> in Markdown documents)
noremap \- yypVr-

" Underline a line with equals (<h1> in Markdown documents)
noremap \= yypVr=

" Handle white space turds
noremap \W :StripWhitespace<cr>
noremap \w :ToggleWhitespace<cr>

" Delete ALL THE BUFFERS!
noremap \bd :1,999bd<cr>:NERDTree<cr>:NERDTree<cr>

" cd current window to parent directory of file
noremap \cd :lcd %:h<cr>:pwd<cr>

" Copy path of current file to clipboard
noremap \cp :let @+ = expand("%")<cr>

" Generate ctags
noremap \ct :!ctags -R .<cr><cr>

" Reload ~/.vimrc
noremap \rc :source ~/.vimrc<cr>

" Sort selection
noremap \s :sort<cr>

" Put contents of parentheses on their own newline and reindent (must position
" cursor inside parentheses in normal mode first).
nmap \( ci(<cr><esc>Pa<cr><esc>Vkk=

" Break a comma-delimited list onto new lines
vmap \, :s/,/,\r/g<cr>

" Ag for string in gem directories, too!
" https://github.com/FergusonSean/dotfiles/blob/master/.vimrc#L109
command! -nargs=* Gag call ag#Ag('grep<bang>', <q-args> . ' . ' . system('bundle show --paths | tr "\n" " "'))

" Replace `:key =>` with `key:`, accommodating extra spaces before the =>
noremap \hr :s/:\(\S\+\)\s*=>/\1:/g<cr>

" Dealing with splits
" Thanks http://flaviusim.com/blog/resizing-vim-window-splits-like-a-boss/
"
" XXX The order and repetition of these width/height settings looks funny, but
" it is what I determined works through experimentation. This was helpful to me
" in finding my way. https://github.com/junegunn/goyo.vim/issues/13
set winwidth=30
set winheight=5
set winminwidth=30
set winminheight=5
set winwidth=80
set winheight=30
nnoremap <silent> _ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> - :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
