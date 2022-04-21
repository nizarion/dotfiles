" Debug vim: vim -V20 2>&1 | tee logfile
let g:gruvbox_contrast_dark = 'hard' " available values: 'hard', 'medium'(default), 'soft'
autocmd vimenter * ++nested colorscheme gruvbox

set tabstop=2
set shiftwidth=2
set expandtab
set ignorecase
set smartindent
set nocompatible
set number " Shows the line numbers
set mouse=a " Allow to use the mouse in the editor
set smartcase
set clipboard=unnamedplus " Automatically use the system clipboard for copy and paste, unnamed is for Linux selection register
set completeopt=noinsert,menuone,noselect " Modifies the auto-complete menu to behave more like an IDE.
set cursorline " Highlights the current line in the editor
set hidden " Hide unused buffers so any buffer can be hidden (keeping its changes) without first writing the buffer to a file
set splitbelow splitright " Change the split screen behavior
set title " Show file title
set wildmenu " Show a more advance menu
set ttyfast " Speed up scrolling in Vim
set inccommand=split " Show replacements in a split screen
set timeoutlen=400 " nvim setting for pop timeout, used by WhichKey
" 5 ones below are mentioned in vim-sensible
"set backspace=indent,eol,start
"set autoindent " Indent a new line
"set spell " enable spell check (may need to download language package)
"syntax on
"filetype plugin indent on   " Allow auto-indenting depending on file type

set viminfo='1000,f1 "save bookmarks between sessions, use uppercase or numeric marks

nnoremap <leader>d "_d "Use the "black hole register", "_ to really delete something
"noremap <Ctrl-.> @:<CR> " Use . to repeat a normal/insert-mode command, @: to repeat a command-line command
"further repeats can be done with @@
tnoremap <Esc> <C-\><C-n> " To get out of Terminal mode using esc
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR> " search for the word under the cursor or visually selected text, just press *.
noremap <Leader>y "+y " + uses CLIPBOARD; mnemonic: CTRL PLUS C (for the common keybind)
noremap <Leader>p "+p
noremap <Leader>Y "*y " * uses PRIMARY; mnemonic: Star is Select (for copy-on-select)
noremap <Leader>P "*p


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
Plug 'preservim/nerdcommenter' " [count]<leader>c<space> |NERDCommenterToggle|
Plug 'vim-airline/vim-airline' " Lean & mean status/tabline for vim that's light as air
Plug 'ntpeters/vim-better-whitespace' " causes all trailing whitespace characters to be highlighted, :StripWhitespace to clean
Plug 'tpope/vim-fugitive'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'morhetz/gruvbox'
Plug 'ervandew/supertab' " Map tab to omnicompletion
Plug 'folke/which-key.nvim'

" Telescope dependancies
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.nvim' "All the lua functions I don't want to write twice
Plug 'BurntSushi/ripgrep'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope.nvim'

" Clojure development
Plug 'neovim/nvim-lspconfig' " brew install clojure-lsp/brew/clojure-lsp-native
Plug 'tpope/vim-dispatch' " Dep for vim-jack-in and vim-dispatch-neovim
Plug 'radenling/vim-dispatch-neovim' " Dep for vim-jack-in, causing a huge terminal to appear, unless you add !, eg Start!
" Plug 'clojure-vim/vim-jack-in' " Jack in to Boot, Clj & Leiningen from Vim, run :Clj! [args], not needed if using vim-iced
Plug 'guns/vim-sexp',    {'for': 'clojure'} " Dep for vim-sexp-mappings-for-regular-people
"Plug 'tpope/vim-sexp-mappings-for-regular-people' " >), <), >(, and <( to slurp and barf
Plug 'luochen1990/rainbow'
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Dep for vim-iced
Plug 'liquidz/vim-iced', {'for': 'clojure'}
Plug 'liquidz/vim-iced-kaocha'
"Plug 'Olical/conjure'
call plug#end()

function! Open_repl()
  "Clj!
  " Using vim-dispatch
  Start! ~/.vim/plugged/vim-iced/bin/iced repl --with-kaocha
endfunction
autocmd FileType clojure, nnoremap <leader>rrr :call Open_repl()<CR>

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

let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

" Telescope
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>f; <cmd>lua require('telescope.builtin').builtin()<cr>
nnoremap <leader>fm <cmd>lua require('telescope.builtin').man_pages()<cr>
nnoremap <leader>fs <cmd>lua require('telescope.builtin').search_history()<cr>
nnoremap <leader>f' <cmd>lua require('telescope.builtin').marks()<cr>
nnoremap <leader>fq <cmd>lua require('telescope.builtin').quickfix()<cr>
nnoremap <leader>fl <cmd>lua require('telescope.builtin').loclist()<cr>
nnoremap <leader>fj <cmd>lua require('telescope.builtin').jumplist()<cr>
nnoremap <leader>fp <cmd>lua require('telescope.builtin').registers()<cr>
nnoremap <leader>fk <cmd>lua require('telescope.builtin').keymaps()<cr>
nnoremap <leader>fc <cmd>lua require('telescope.builtin').commands()<cr>
nnoremap <leader>fr <cmd>lua require('telescope.builtin').lsp_references()<cr>
nnoremap <leader>ft <cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>
nnoremap <leader>fa <cmd>lua require('telescope.builtin').lsp_code_actions()<cr>
nnoremap <leader>fi <cmd>lua require('telescope.builtin').lsp_implementations()<cr>
nnoremap <leader>fd <cmd>lua require('telescope.builtin').lsp_definitions()<cr>

" Nvim-tree
let g:nvim_tree_git_hl = 1 "0 by default, will enable file highlight for git attributes (can be used without the icons).
let g:nvim_tree_highlight_opened_files = 1 "0 by default, will enable folder and file icon highlight for opened files/directories.
let g:nvim_tree_root_folder_modifier = ':~' "This is the default. See :help filename-modifiers for more options
let g:nvim_tree_add_trailing = 1 "0 by default, append a trailing slash to folder names
let g:nvim_tree_group_empty = 1 " 0 by default, compact folders that only contain a single folder into one node in the file tree
let g:nvim_tree_icon_padding = ' ' "one space by default, used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.
let g:nvim_tree_symlink_arrow = ' >> ' " defaults to ' ➛ '. used as a separator between symlinks' source and target.
let g:nvim_tree_respect_buf_cwd = 1 "0 by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.
let g:nvim_tree_create_in_closed_folder = 1 "0 by default, When creating files, sets the path of a file when cursor is on a closed folder to the parent folder when 0, and inside the folder when 1.
let g:nvim_tree_special_files = { 'README.md': 1, 'Makefile': 1, 'MAKEFILE': 1 } " List of filenames that gets highlighted with NvimTreeSpecialFile
let g:nvim_tree_show_icons = { 'git': 0, 'folders': 0, 'files': 0, 'folder_arrows': 0,}
nnoremap <leader>nn :NvimTreeToggle<CR>
nnoremap <leader>nr :NvimTreeRefresh<CR>
nnoremap <leader>nf :NvimTreeFindFile<CR>
set termguicolors " this variable must be enabled for colors to be applied properly
highlight NvimTreeFolderIcon guibg=blue

" vim-sexp
" Disable mapping hooks
let g:sexp_filetypes = ''

"function! s:vim_sexp_mappings()
  "nmap <silent><buffer> >)         <Plug>(sexp_emit_head_element)
  "xmap <silent><buffer> >)         <Plug>(sexp_emit_head_element)
  "nmap <silent><buffer> <)         <Plug>(sexp_emit_tail_element)
  "xmap <silent><buffer> <)         <Plug>(sexp_emit_tail_element)
  "nmap <silent><buffer> >(         <Plug>(sexp_capture_prev_element)
  "xmap <silent><buffer> >(         <Plug>(sexp_capture_prev_element)
  "nmap <silent><buffer> <)         <Plug>(sexp_capture_next_element)
  "xmap <silent><buffer> <)         <Plug>(sexp_capture_next_element)
"endfunction

"augroup VIM_SEXP_MAPPING
  "autocmd!
  "autocmd FileType clojure,scheme,lisp,timl call s:vim_sexp_mappings()
"augroup END

" vim-iced
" Enable vim-iced's default key mapping
let g:iced_enable_default_key_mappings = v:true

nmap <Leader>>) <Plug>(iced_barf)
nmap <Leader><) <Plug>(iced_barf)
nmap <Leader>eP <Plug>(iced_eval_and_print)<Plug>(sexp_outer_list)``
nmap <Leader>ewt <Plug>(iced_eval_and_tap)<Plug>(sexp_outer_list)``
nmap <Leader>ewc <Plug>(iced_eval_and_comment)<Plug>(sexp_outer_list)``

lua << EOF

-- lspconfig

-- Mappings.
local opts = { noremap=true, silent=true }
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
-- Enable completion triggered by <c-x><c-o>
vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

-- Mappings.
-- See `:help vim.lsp.*` for documentation on any of the below functions
vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'clojure_lsp' }
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
      }
    }
end

-- which-key
require("which-key").setup {
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
}

-- Telescope
require('telescope').setup{
defaults = {
  mappings = {
    i = {
      -- map actions.which_key to <C-h> (default: <C-/>)
      -- actions.which_key shows the mappings for your picker,
      -- e.g. git_{create, delete, ...}_branch for the git_branches picker
      ["<C-h>"] = "which_key"
      }
    }
  },
  extensions = {
    fzf = {}
  }
}
require('telescope').load_extension('fzf')


-- Treesitter
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "clojure", "lua", "bash","python" ,"ruby" ,"yaml" ,"vim" ,"json"},

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  highlight = {
    enable = true, -- `false` will disable the whole extension
    additional_vim_regex_highlighting = false,
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
}


-- nvim-tree
require'nvim-tree'.setup{
  hijack_cursor = true,
  renderer = {
    indent_markers = {
    enable = true,
    },
  },
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  update_focused_file = {
    enable = true,
    update_cwd = false,
    ignore_list = {},
  },
}
EOF
