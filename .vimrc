"VUNDLE PLUGIN MANAGER
set nocompatible
filetype off
filetype plugin on    " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive' "adds the Git wrapper
Plugin 'tpope/vim-surround' "adds the surround options (cs)
Plugin 'tmux-plugins/vim-tmux-focus-events' "restores some commands in vim inside tmux
Plugin 'jnurmine/Zenburn' "Zenburn colorscheme
Plugin 'vim-airline/vim-airline' "extended statusbar for vim
Plugin 'vim-airline/vim-airline-themes' "extended statusbar for vim
Plugin 'dense-analysis/ale' "extended syntax checks (syntastic is deprecated)
Plugin 'morhetz/gruvbox'
Plugin 'sheerun/vim-polyglot' "A solid language pack for vim
Plugin 'hashivim/vim-terraform' "basic vim/terraform integration
Plugin 'airblade/vim-gitgutter' "Plugin which shows a git iff in the gutter
Plugin 'burnettk/vim-jenkins' "interacts with Jenkins interface via API
Plugin 'edkolev/tmuxline.vim' "add vim-airline to tmux
Plugin 'Yggdroot/indentline' "add lines on indentj
" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)

" ...

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"HASHIVIM SETTINGS
let g:terrafrom_align=1 "allow vim to align settings autamtically with tabularize
let g:terraform_fold_sections=1 "allow vim to automatically fold sections of terraform code (0 is off)
let g:terraform_fmt_on_save=1 "allow to automatically format *.tf and *.tfvars files with terraform fmt (:terraformFmt command)

"TMUXLINE-VIM-SETTINGS
let g:tmuxline_powerline_separators = 1

"VIM_JENKINS SETTINGS
let g:jenkins_url = 'http://localhost:8080'
let g:jenkins_username = 'kporwit'
let g:jenkins_password = 'admin'

"GITGUTTER SETTINGS
nnoremap <F6> :GitGutterToggle<CR>

"VIM_AIRLINE SETTINGS
let g:airline_powerline_fonts = 1

"SET THE DIRECTORIES FOR THE BACKUP SWAP AND UNDO FILES
set backup "sets backup
set backupdir=/home/kporwit/.vim/backup//
set directory=/home/kporwit/.vim/swap//
set undodir=/home/kporwit/.vim/undo//
set writebackup "enable backup support

"UI CONFIG
set showcmd "show command in the bottom bar
syntax on "set the syntax highlighting
set cursorline "highlight current line
"filetype indent on "load filetype-specific indent files
set wildmenu "visual autocomplete for command menu
":find goes for subdirs
set path +=**
set lazyredraw "redraw only when need to
set showmatch "highlight matching [{()}]
set nocompatible "vim stop trying to be vi
set encoding=utf-8 "set encoding to all files to UTF-8
set number relativenumber "set the line numbers and relaitvenumers
"switch between number in insert and rnumber in normal
augroup numbertoggle
   autocmd!
   autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
   autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END
set autoread "automatically reads a file from a disk

"FILE BROWSING NETRW
let g:netrw_banner=0 "disables netrw banner
let g:netrw_browse_split=4 "opens in a window
let g:netrw_altr=1 "makes splits to the right
let g:netrw_liststyle=3 "makes tree view
let g:netrw_list_hide=netrw_gitignore#Hide() "ignores file listed in git ignore

"SYNTASTIC
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
"SYNTASTIC Checkers
let g:syntastic_yaml_checkers = ['yamllint']
let g:syntastic_yml_checkers = ['yamllint']

"SEARCHING
set hlsearch "highlight matches
"Toggles between hlsearch on and off:
nnoremap <F4> :set hlsearch!<CR><Bar>:echo 'highlight search: ' . ['Off', 'On'][&hlsearch]<CR> 

"FOLDING
set foldenable "enables folding
set foldlevelstart=10 "open most folds by default
set foldnestmax=10 "10 max nested folds
set foldmethod=indent "fold based on indent level
"space open/closes folds
nnoremap <space> za

"SET TAB AS FOUR SPACES IN ALL DOCUMENTS
set tabstop=4 "number of visual spaces per tab
set softtabstop=4 "number of spaces in tab when editing
set expandtab "tabs ARE spaces

"MOVEMENT
nnoremap j gj
nnoremap k gk
inoremap jk <esc>

"COLORSCHEMES
set t_Co=256 "enable256 colors in vim
set background=dark
let g:gruvbox_termcolors=256
colorscheme gruvbox
"colorscheme zenburn
nnoremap <F5> :let &background = ( &background == "dark"? "light" : "dark" )<CR>
set term=screen-256color
set t_ut=

"BASH SUPPORT
let g:BASH_AuthorName   = 'Kamil Porwit'
let g:BASH_Email        = 'kamilporwit93@gmail.com'

"JENKINS FILES SPECIFIC
au BufNewFile,BufRead *.jenkinsfile setf groovy
au BufNewFile,BufRead *.jenkinsfile set tabstop=2
au BufNewFile,BufRead *.jenkinsfile set softtabstop=2
au BufNewFile,BufRead *.jenkinsfile set expandtab
au BufNewFile,BufRead *.jenkinsfile set autoindent
au BufNewFile,BufRead *.jenkinsfile set fileformat=unix

"TERRAFORM FILES SPECIFIC
au BufNewFile,BufRead *.tf set tabstop=2
au BufNewFile,BufRead *.tf set softtabstop=2
au BufNewFile,BufRead *.tf set expandtab

"PYTHON FILES SPECIFIC
au BufNewFile,BufRead *.py set tabstop=4
au BufNewFile,BufRead *.py set softtabstop=4
au BufNewFile,BufRead *.py set expandtab
au BufNewFile,BufRead *.py set textwidth=79
au BufNewFile,BufRead *.py set autoindent
au BufNewFile,BufRead *.py set fileformat=unix

"SHELL FILES SPECIFIC
au BufNewFile,BufRead *.sh set tabstop=4
au BufNewFile,BufRead *.sh set softtabstop=4
au BufNewFile,BufRead *.sh set expandtab
"au BufNewFile,BufRead *.sh set autoindent
au BufNewFile,BufRead *.sh set fileformat=unix

"YAML FILES SPECIFIC
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab fileformat=unix
autocmd FileType yml setlocal ts=2 sts=2 sw=2 expandtab fileformat=unix
