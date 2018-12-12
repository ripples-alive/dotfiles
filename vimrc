" vim:fdm=marker

colorscheme desert

" Preamble {{{
set nocompatible
" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure
" Respect modeline in files
set modeline
set modelines=4
" Mapleader
let mapleader=","
" }}}

" Local directories {{{
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
set undodir=~/.vim/undo

" Don't create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*
" }}}

" Encoding {{{
augroup encoding_config
    autocmd!
    " Use UTF-8 without BOM
    set encoding=utf-8 nobomb
    " Detect file encodings
    set fileencodings=ucs-bom,utf-8,cp936,gbk18030,big5,euc-jp,euc-kr,latin1
    " <F4> to force open as gbk
    map <F4> :edit ++enc=gbk<CR>
augroup end
" }}}

" Mixin {{{
augroup mixin
    autocmd!

    syntax on " Enable syntax highlighting
    set diffopt=filler " Add vertical spaces to keep right and left aligned
    set diffopt+=iwhite " Ignore whitespace changes (focus on code changes)
    set esckeys " Allow cursor keys in insert mode
    set hidden " When a buffer is brought to foreground, remember undo history and marks
    set history=1000 " Increase history from 20 default to 1000
    set laststatus=2 " Always show status line
    set lazyredraw " Don't redraw when we don't have to
    set magic " Enable extended regexes
    set noerrorbells " Disable error bells
    set nojoinspaces " Only insert single space after a '.', '?' and '!' with a join command
    set nostartofline " Don't reset cursor to start of line when moving around
    set report=0 " Show all changes
    set ruler " Show the cursor position
    set scrolloff=3 " Start scrolling three lines before horizontal border of window
    set shortmess=atI " Don't show the intro message when starting vim
    set showcmd " Show the (partial) command as it’s being typed
    set showmatch " Highlight the matching bracket or brace
    set showtabline=2 " Always show tab bar
    set sidescrolloff=3 " Start scrolling three columns before vertical border of window
    set splitbelow " New window goes below
    set splitright " New windows goes right
    set suffixes=.bak,~,.swp,.swo,.o,.d,.info,.aux,.log,.dvi,.pdf,.bin,.bbl,.blg,.brf,.cb,.dmg,.exe,.ind,.idx,.ilg,.inx,.out,.toc,.pyc,.pyd,.dll
    set switchbuf=""
    set title " Show the filename in the window titlebar
    set ttyfast " Send more characters at a given time
    set undofile " Persistent Undo
    set viminfo=%,'9999,s512,n~/.vim/viminfo " Restore buffer list, marks are remembered for 9999 files, registers up to 512Kb are remembered
    set visualbell " Use visual bell instead of audible bell (annnnnoying)
    set wildchar=<TAB> " Character for CLI expansion (TAB-completion)
    set wildmenu " Hitting TAB in command mode will show possible completions above command line
    set wildmode=list:longest " Complete only until point of ambiguity
    set winminheight=0 " Allow splits to be reduced to a single line
    set wrapscan " Searches wrap around end of file

    " Insert newline
    map <leader><Enter> o<ESC>
    " Close Quickfix window (,qq)
    map <leader>qq :cclose<CR>

    " Join lines and restore cursor location (J)
    nnoremap J mjJ`j
augroup end
" }}}

" Search {{{
augroup search_config
    autocmd!

    set gdefault " By default add g flag to search/replace. Add g to toggle
    set hlsearch " Highlight searches
    set ignorecase " Ignore case of searches
    set incsearch " Highlight dynamically as pattern is typed
    set smartcase " Ignore 'ignorecase' if search patter contains uppercase characters

    " <F3> for canceling hightlight after search
    map <F3> :nohl<CR>
augroup end
" }}}

" Wrap {{{
augroup wrap_config
    autocmd!
    set nowrap " Do not wrap lines
    " <F7> toggle line wrap
    noremap <silent> <F7> :set wrap!<CR>
    imap <silent><F7> <C-O><F7>
augroup end
" }}}

" Format {{{
augroup format_config
    autocmd!

    set formatoptions=
    set formatoptions+=c " Format comments
    set formatoptions+=r " Continue comments by default
    set formatoptions+=o " Make comment when using o or O from comment line
    set formatoptions+=q " Format comments with gq
    set formatoptions+=n " Recognize numbered lists
    set formatoptions+=2 " Use indent from 2nd line of a paragraph
    set formatoptions+=l " Don't break lines that are already long
    set formatoptions+=1 " Break before 1-letter words
augroup end
" }}}

" Line number & Invisible characters {{{
augroup line_number_control
    autocmd!

    " Enable line numbers
    set number
    " Use relative line numbers
    if exists("&relativenumber")
        set relativenumber " Use relative line numbers. Current line is still in status bar.
        au BufReadPost,BufNewFile * set relativenumber
    endif

    " Show 'invisible' characters
    set list
    set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_

    " <F6> toggle line number & invisible characters
    noremap <silent> <F6> :set nu!<CR> :set norelativenumber!<CR> :set list!<CR> :IndentLinesToggle<CR>
    imap <silent><F6> <C-O><F6>
augroup end
" }}}

" Copy/Paste {{{
augroup paste_control
    autocmd!
    " set clipboard=unnamed " Use the OS clipboard by default (on versions compiled with `+clipboard`)
    set pastetoggle=<F8> " <F8> toggle paste
    noremap <leader>y "+y
    noremap <leader>p "+p
augroup end
" }}}

" Write file {{{
augroup write_file
    autocmd!
    map <F2> :w<CR>
    " Sudo write (,w / :w!!)
    noremap <leader>w :w !sudo tee % > /dev/null<CR>
    cmap w!! w !sudo tee %
augroup end
" }}}

" Strip trailing whitespace (,ss) {{{
augroup tailing_space
    autocmd!
    function! StripWhitespace()
        let save_cursor = getpos(".")
        let old_query = getreg('/')
        :%s/\s\+$//e
        call setpos('.', save_cursor)
        call setreg('/', old_query)
    endfunction
    noremap <leader>ss :call StripWhitespace()<CR>
augroup end
" }}}

" Fold {{{
augroup fold_config
    autocmd!

    set foldcolumn=0 " Column to show folds
    set foldenable " Enable folding
    set foldlevel=99 " Open all folds by default
    set foldmethod=syntax " Syntax are used to specify folds
    set foldminlines=0 " Allow folding single lines
    set foldnestmax=5 " Set max fold nesting level

    " Toggle folds (<Space>)
    nnoremap <silent> <space> :exe 'silent! normal! '.((foldclosed('.')>0)? 'zMzx' : 'zc')<CR>
augroup end
" }}}

" Indent {{{
augroup indent_config
    autocmd!

    set autoindent
    set cindent
    set smartindent

    set expandtab
    set softtabstop=4
    set tabstop=4
    set shiftwidth=4

    set smarttab " At start of line, <Tab> inserts shiftwidth spaces, <Bs> deletes shiftwidth spaces
    set backspace=indent,eol,start
augroup end
" }}}

" Ignore {{{
augroup ignore_config
    autocmd!
    set wildignore+=.DS_Store
    set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.o,*.obj,*.min.js
    set wildignore+=*/bower_components/*,*/node_modules/*
    set wildignore+=*/smarty/*,*/vendor/*,*/.git/*,*/.hg/*,*/.svn/*,*/.sass-cache/*,*/log/*,*/tmp/*,*/build/*,*/ckeditor/*,*/doc/*,*/source_maps/*,*/dist/*
augroup end
" }}}

" Buffers {{{
augroup buffer_control
    autocmd!

    " Prompt for buffer to select (,b) {{{
    nnoremap <leader>b :Buffers<CR>
    " }}}

    " Buffer navigation (,,) (gb) (gB) (,ls) {{{
    map <leader>, <C-^>
    map <leader>ls :buffers<CR>
    map gb :bnext<CR>
    map gB :bprev<CR>
    " }}}

    " Jump to buffer number (<N>gb) {{{
    let c = 1
    while c <= 99
        execute "nnoremap " . c . "gb :" . c . "b\<CR>"
        let c += 1
    endwhile
    " }}}
augroup end
" }}}

" Fix page up and down {{{
augroup fix_page_key
    autocmd!
    map <PageUp> <C-U>
    map <PageDown> <C-D>
    imap <PageUp> <C-O><C-U>
    imap <PageDown> <C-O><C-D>
augroup end
" }}}

" Filetypes {{{

" Makefile {{{
augroup filetype_makefile
    autocmd!
    autocmd FileType make setlocal noexpandtab " Use TAB for makefile
augroup end
" }}}

" Markdown {{{
augroup filetype_markdown
    autocmd!
    let g:markdown_fenced_languages = ['ruby', 'html', 'javascript', 'css', 'erb=eruby.html', 'bash=sh']
augroup END
" }}}

" JSON {{{
augroup filetype_json
    autocmd!
    au BufRead,BufNewFile *.json set ft=json syntax=javascript
augroup END
" }}}

" ZSH {{{
augroup filetype_zsh
    autocmd!
    au BufRead,BufNewFile .zsh_rc,.functions,.commonrc set ft=zsh
augroup END
" }}}

" }}}

" Plugin Configuration {{{

" Vim-airline {{{
augroup airline_config
    autocmd!
    let g:airline_theme='dark'
    let g:airline#extensions#tabline#enabled=1
augroup end
" }}}

" NERDTree {{{
augroup nerdtree_config
    autocmd!
	map <C-n> :NERDTreeToggle<CR>

	" NERDTress File highlighting
	function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
		exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
		exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
	endfunction

	call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
	call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
	call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
	call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
	call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
	call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
	call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
	call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
	call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
	call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
	call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
	call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
	call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
augroup end
" }}}

" Tagbar {{{
augroup tagbar_config
    autocmd!
    nmap <F10> :TagbarToggle<CR>
augroup end
" }}}

" Vim-easymotion {{{
augroup vim_easymotion
    autocmd!
    let g:EasyMotion_do_mapping = 0 " Disable default mappings
    let g:EasyMotion_smartcase = 1 " Turn on case insensitive feature
    let g:EasyMotion_startofline = 0 " keep cursor column when JK motion

    " Jump to anywhere you want with minimal keystrokes, with just one key binding.
    " `s{char}{label}`
    nmap s <Plug>(easymotion-overwin-f)

    " hjkl motions
    map <Leader>h <Plug>(easymotion-linebackward)
    map <Leader>j <Plug>(easymotion-j)
    map <Leader>k <Plug>(easymotion-k)
    map <Leader>l <Plug>(easymotion-lineforward)
augroup end
" }}}

" NERD Commenter {{{
augroup nerd_commenter
    autocmd!
    let g:NERDSpaceDelims = 1 " Add spaces after comment delimiters by default
    let g:NERDCustomDelimiters = {'python': {'left': '#'}} " Prevent two spaces for python instead of one
    let g:NERDCompactSexyComs = 1 " Use compact syntax for prettified multi-line comments
    let g:NERDDefaultAlign = 'left' " Align line-wise comment delimiters flush left instead of following code indentation
    let g:NERDCommentEmptyLines = 1 " Allow commenting and inverting empty lines (useful when commenting a region)
    let g:NERDTrimTrailingWhitespace = 1 " Enable trimming of trailing whitespace when uncommenting
    let g:NERDToggleCheckAllLines = 1 " Enable NERDCommenterToggle to check all selected lines is commented or not 
augroup end
" }}}

" fzf.vim {{{
augroup fzf_config
    autocmd!

    " Extra key bindings {{{
    let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-h': 'split',
      \ 'ctrl-v': 'vsplit' }
    " }}}

    " Customize fzf colors to match your color scheme {{{
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
    " }}}

    " Command-local options {{{
    " [Buffers] Jump to the existing window if possible
    let g:fzf_buffers_jump = 1
    " [[B]Commits] Customize the options used by 'git log':
    let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
    " [Tags] Command to generate tags file
    let g:fzf_tags_command = 'ctags -R'
    " [Commands] --expect expression for directly executing the command
    let g:fzf_commands_expect = 'alt-enter,ctrl-x'
    " }}}

    " Shortcut key bindings {{{
    nnoremap <leader>f :Filetypes<CR>
    nnoremap <leader>c :Commits<CR>

    nnoremap <leader>g :Lines<Space>
    map <C-g> :BLines<Space>

    map <C-p> :Files<CR>
    map <C-o> :GFiles<CR>
    nnoremap <leader>a :Ag<Space>
    map gl :Locate<Space>
    " }}}
augroup end
" }}}

" Fugitive.vim {{{
augroup fugitive_config
    autocmd!
    map gs :Gstatus<CR>
augroup end
" }}}

" Load plugins {{{
call plug#begin('~/.vim/plugged')

" Beautify
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Yggdroot/indentLine'

" Code navigation
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'majutsushi/tagbar'
Plug 'easymotion/vim-easymotion'

" Fantastic fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

" Misc utils
Plug 'tpope/vim-fugitive'
Plug 'christoomey/vim-tmux-navigator'
Plug 'thinca/vim-quickrun'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'scrooloose/nerdcommenter'

" Auto complete
Plug 'vim-scripts/L9'
Plug 'othree/vim-autocomplpop'

" Snippet
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'

call plug#end()
" }}}

" }}}
