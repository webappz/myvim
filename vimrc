" Use pathogen plugin to manage easily plugins as git submodules.
" Setup Bundle Support
"
runtime! autoload/pathogen.vim
silent! call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Modeline and Notes {
" vim: set foldmarker={,} foldlevel=0 foldmethod=marker spell:
"
"   This is the personal .vimrc file of Steve Francia.
"   While much of it is beneficial for general use, I would
"   recommend picking out the parts you want and understand.
"
"   You can find me at http://spf13.com
" }
 
" Environment {
    " Basics {
        set nocompatible        " must be first line
    " }
 
    " Windows Compatible {
        " On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
        " across (heterogeneous) systems easier.
        if has('win32') || has('win64')
          set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
        endif
    " }
 
" } 
 
" General {
    set background=dark         " Assume a dark background
    set term=builtin_ansi       " Make arrow and other keys work
    filetype plugin indent on   " Automatically detect file types.
    syntax on                   " syntax highlighting
    set mouse=a                 " automatically enable mouse usage
    "set autochdir              " always switch to the current file directory..
    " not every vim is compiled with this, use the following line instead
    " If you use command-t plugin, it conflicts with this, comment it out.
     "autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
    scriptencoding utf-8        " Use utf-8 encoding
    set autowrite                  " automatically write a file when leaving a modified buffer
    set shortmess+=filmnrxoOtT      " abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility
    set virtualedit=onemore         " allow for cursor beyond last character
    set history=1000                " Store a ton of history (default is 20)
    set spell                       " spell checking on
 
    " Setting up the directories {
        set backup                      " backups are nice ...
        set backupdir=$HOME/.vimbackup//  " but not when they clog .
        set directory=$HOME/.vimswap//  " Same for swap files
        set viewdir=$HOME/.vimviews//   " same for view files
 
        "" Creating directories if they don't exist
        silent execute '!mkdir -p $HOME/.vimbackup'
        silent execute '!mkdir -p $HOME/.vimswap'
        silent execute '!mkdir -p $HOME/.vimviews'
        au BufWinLeave * silent! mkview  "make vim save view (state) (folds, cursor, etc)
        au BufWinEnter * silent! loadview "make vim load view (state) (folds, cursor, etc)
    " }
" }
 
" Vim UI {
    color wombat                   " load a colorscheme
    set tabpagemax=15               " only show 15 tabs
    set showmode                    " display the current mode
 
    set cursorline                  " highlight current line
    hi cursorline guibg=#333333     " highlight bg color of current line
    hi CursorColumn guibg=#333333   " highlight cursor
 
    if has('cmdline_info')
        set ruler                   " show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
        set showcmd                 " show partial commands in status line and
                                    " selected characters/lines in visual mode
    endif
 
    if has('statusline')
        set laststatus=1            " show statusline only if there are > 1 windows
        " Use the commented line if fugitive isn't installed
        "set statusline=%<%f\ %=\:\b%n%y%m%r%w\ %l,%c%V\ %P " a statusline, also on steroids
        set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
    endif
 
    set backspace=indent,eol,start  " backspace for dummys
    set linespace=0                 " No extra spaces between rows
    set number                      " Line numbers on
    set showmatch                   " show matching brackets/parenthesis
    set incsearch                   " find as you type search
    set hlsearch                    " highlight search terms
    set winminheight=0              " windows can be 0 line high
    set ignorecase                  " case insensitive search
    set smartcase                   " case sensitive when uc present
    set wildmenu                    " show list instead of just completing
    set wildmode=list:longest,full  " comand <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " backspace and cursor keys wrap to
    set scrolljump=5                " lines to scroll when cursor leaves screen
    set scrolloff=3                 " minimum lines to keep above and below cursor
    set foldenable                  " auto fold code
    set gdefault                    " the /g flag on :s substitutions by default
 
" }
 
" Formatting {
    
    set expandtab                   " convert tabs to spaces
    set softtabstop=2               " tab of length 2
    set shiftwidth=2                " indentation tab to 2 spaces
    set nowrap                      " wrap long lines
    set autoindent                  " indent at the same level of the previous line
    set tabstop=2                   " an indentation every two columns
    "set matchpairs+=<:>            " match, to be used with %
    set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
    "set comments=sl:/*,mb:*,elx:*/ " auto format comment blocks
" }
 
" Key Mappings {
 
    " Easier moving in tabs and windows
    map <C-J> <C-W>j<C-W>_
    map <C-K> <C-W>k<C-W>_
    map <C-L> <C-W>l<C-W>_
    map <C-H> <C-W>h<C-W>_
    map <C-K> <C-W>k<C-W>_
    " The following two lines conflict with moving to top and bottom of the
    " screen
    " If you prefer that functionality, comment them out.
    map <S-H> gT
    map <S-L> gt
 
    " Stupid shift key fixes
    cmap W w
    cmap WQ wq
    cmap wQ wq
    cmap Q q
    cmap Tabe tabe
 
    " Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$
 
    " Shortcuts
    " Change Working Directory to that of the current file
    cmap cwd lcd %:p:h
 
    " For when you forget to sudo.. Really Write the file.
    cmap w!! w !sudo tee % >/dev/null
" }
 
" Plugins {
 
    " Supertab {
        "let g:SuperTabDefaultCompletionType = "context"
        let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
    " }
 
    " Misc {
        :map <C-F10> <Esc>:vsp<CR>:VTree<CR>
        " map Control + F10 to Vtree
 
        let g:checksyntax_auto = 0
 
        "comment out line(s) in visual mode
        vmap  o  :call NERDComment(1, 'toggle')<CR>
        let g:NERDShutUp=1
 
        let b:match_ignorecase = 1
    " }
     
    " OmniComplete {
        "if has("autocmd") && exists("+omnifunc")
            "autocmd Filetype *
                "\if &omnifunc == "" |
                "\setlocal omnifunc=syntaxcomplete#Complete |
                "\endif
        "endif
        "

        au BufNewFile,BufRead *.module set filetype=php
        au BufNewFile,BufRead *.test set filetype=php
        au BufNewFile,BufRead *.install set filetype=php
        au BufNewFile,BufRead *.inc set filetype=php

        autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
        autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
        autocmd FileType css set omnifunc=csscomplete#CompleteCSS
        autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
        autocmd FileType php set omnifunc=phpcomplete#CompletePHP
        autocmd FileType inc set omnifunc=phpcomplete#CompletePHP
 
        " Popup menu hightLight Group
        "highlight Pmenu    ctermbg=13  guibg=DarkBlue
        highlight PmenuSel  ctermbg=7   guibg=DarkBlue      guifg=LightBlue
        "highlight PmenuSbar ctermbg=7  guibg=DarkGray
        "highlight PmenuThumb           guibg=Black
 
        hi Pmenu  guifg=#000000 guibg=#F8F8F8 ctermfg=black ctermbg=Lightgray
        hi PmenuSbar  guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan ctermbg=lightgray cterm=NONE
        hi PmenuThumb  guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray ctermbg=darkcyan cterm=NONE
 
        " some convenient mappings
        inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
        inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
        inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
        inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
        inoremap <expr> <C-d>      pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
        inoremap <expr> <C-u>      pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"
 
        " automatically open and close the popup menu / preview window
        au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
        set completeopt=menu,longest,preview
    " }
 
    " Ctags {
        set tags=./tags;/,~/.vimtags
    " }
 
    " EasyTags {
        let g:easytags_cmd = '/usr/local/bin/ctags'
    " }
 
    " Delimitmate {
        au FileType * let b:delimitMate_autoclose = 1
 
        " If using html auto complete (complete closing tag)
        au FileType xml,html,xhtml let b:delimitMate_matchpairs = "(:),[:],{:}"
    " }
 
    " AutoCloseTag {
        " Make it so AutoCloseTag works for xml and xhtml files as well
        au FileType xhtml,xml ru ftplugin/html/autoclosetag.vim
    " }
 
    " SnipMate {
        " Setting the author var
        let g:snips_author = 'Steve Francia <steve.francia@gmail.com>'
        " Shortcut for reloading snippets, useful when developing
        nnoremap ,smr <esc>:exec ReloadAllSnippets()<cr>
    " }
" }
 
" GUI Settings {
    " GVIM- (here instead of .gvimrc)
    if has('gui_running')
        set guioptions-=T           " remove the toolbar
        set lines=40                " 40 lines of text instead of 24,
    endif
" }







" syntax on

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
" colorscheme wombat
" set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
" if has("autocmd")
"  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
"    \| exe "normal g'\"" | endif
" endif

" Uncomment the following to have Vim load indentation rules according to the
" detected filetype. Per default Debian Vim only load filetype specific
" plugins.
"if has("autocmd")
"  filetype indent on
"endif

set tags=./tags;/var/www

" custom keybinginds (left key press perform the right key commands)

" Toggle fold
"noremap f za
" Close all folds
"noremap F zM
" Open all folds
"noremap ,f zR

