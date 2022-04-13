"set background=dark
" set contrast
" this configuration option should be placed before `colorscheme gruvbox-material`
" available values: 'hard', 'medium'(default), 'soft'
let g:gruvbox_contrast_dark = 'hard'
autocmd vimenter * ++nested colorscheme gruvbox

set tabstop=2
set shiftwidth=2
set expandtab
set ignorecase
set smartindent
set autoindent " Indent a new line

set nocompatible
set backspace=indent,eol,start
syntax on
set number " Shows the line numbers
set mouse=a " Allow to use the mouse in the editor
set smartcase
filetype plugin indent on   " Allow auto-indenting depending on file type
" Automatically use the system clipboard for copy and paste
"set clipboard=unnamed,unnamedplus
set clipboard=unnamedplus " Enables the clipboard between Vim/Neovim and other applications.

set completeopt=noinsert,menuone,noselect " Modifies the auto-complete menu to behave more like an IDE.
set cursorline " Highlights the current line in the editor
set hidden " Hide unused buffers so any buffer can be hidden (keeping its changes) without first writing the buffer to a file
set splitbelow splitright " Change the split screen behavior
set title " Show file title
set wildmenu " Show a more advance menu
"set spell " enable spell check (may need to download language package)
set ttyfast " Speed up scrolling in Vim

" search for the word under the cursor, just press *.
" search for visually selected text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

noremap <Leader>Y "*y
noremap <Leader>P "*p
noremap <Leader>y "+y
noremap <Leader>p "+p

" Switch buffer, press F5 then the buffer number
"nnoremap <F5> :buffers<CR>:buffer<Space>

" To get out of Terminal mode, we have to press control-backslash-control-n. That's awkward!
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
  set inccommand=split " Show replacements in a split screen
endif

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif
" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
      \| PlugInstall --sync | source $MYVIMRC
      \| endif

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'vim-airline/vim-airline'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-fugitive'

"[count]<leader>c<space> |NERDCommenterToggle|
Plug 'preservim/nerdcommenter'

" brew install fzf
" To install useful key bindings and fuzzy completion:
" $(brew --prefix)/opt/fzf/install
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'junegunn/fzf.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.nvim'
Plug 'BurntSushi/ripgrep'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope.nvim'
" Press <C-p> to search files, <c-f> to change mode
"Plug 'ctrlpvim/ctrlp.vim'
"Plug 'g979/vim-visual-multi'
Plug 'preservim/nerdtree'
Plug 'morhetz/gruvbox'
"Plug 'ervandew/supertab'
" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Clojure development

" https://github.com/tpope/vim-fireplace
" Dep for async-clj-omni
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Enhanced REPL using CIDER API (need to install more stuff)
" https://github.com/SevereOverfl0w/vim-replant
"Plug 'SevereOverfl0w/vim-replant', { 'do': ':UpdateRemotePlugins' }

" Jack in to Boot, Clj & Leiningen from Vim, run :Clj [args]
Plug 'clojure-vim/vim-jack-in'
Plug 'tpope/vim-dispatch' " Dep for vim-jack-in

" Asynchronous Lint Engine, Laguage Server Protocol client
"Plug 'dense-analysis/ale'
"Plug 'vim-syntastic/syntastic' " Not async
Plug 'neomake/neomake'

" https://github.com/tpope/vim-sexp-mappings-for-regular-people
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'guns/vim-sexp' " Dep for vim-sexp-mappings-for-regular-people

"Plug 'guns/vim-clojure-highlight'
"Plug 'guns/vim-clojure-static'
Plug 'luochen1990/rainbow'

" https://github.com/prabirshrestha/asyncomplete.vim
Plug 'prabirshrestha/asyncomplete.vim'
" Provides async clojure completion for dependancy asyncomplete.vim
Plug 'clojure-vim/async-clj-omni'

" Only in Neovim:
if has('nvim')
  Plug 'Olical/conjure'
  "Plug 'radenling/vim-dispatch-neovim' " Dep for vim-jack-in, causing a huge terminal to appear
endif
call plug#end()

" vim-airline
let g:airline#extensions#tabline#enabled = 1

" Syntastic https://github.com/vim-syntastic/syntastic#settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

map <C-o> :NERDTreeToggle<CR>

"nnoremap <silent> <C-p> :Files<CR>
"nnoremap <silent> <F4> :GFiles<CR>
"nnoremap <silent> <F5> :Buffers<CR>
"nnoremap <F3> :Rg!<CR>

let g:ctrlp_root_markers = ['deps.edn']
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

" clj-kondo should be installed on operating system path
let g:ale_linters = {
      \ 'clojure': ['clj-kondo']
      \}
" Neomake (linting) When writing a buffer (no delay).
call neomake#configure#automake('w')

au User asyncomplete_setup call asyncomplete#register_source({
      \ 'name': 'async_clj_omni',
      \ 'whitelist': ['clojure'],
      \ 'completor': function('async_clj_omni#sources#complete'),
      \ })

" tab to show the autocomplete popup
let g:asyncomplete_auto_popup = 0

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ asyncomplete#force_refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

let g:asyncomplete_auto_completeopt = 0

set completeopt=menuone,noinsert,noselect,preview

nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

lua << EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "clojure", "lua" },
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  highlight = {
    -- `false` will disable the whole extension
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
      },
    },
  indent = {
  enable = true
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      -- override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    }
  }
}

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')
EOF
