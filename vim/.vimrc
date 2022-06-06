" vimrc for neovim
" Autor: nizarion
" vim -V20 2>&1 | tee logfile (debugging vimrc)

" Theme - coloscheme
"let g:gruvbox_contrast_dark = 'hard' " available values: 'hard', 'medium'(default), 'soft'
set background=dark " or light if you want light mode
autocmd vimenter * ++nested colorscheme gruvbox

" Plugins
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
" General
Plug 'ellisonleao/gruvbox.nvim'
Plug 'mhinz/vim-startify'
"Plug 'ervandew/supertab' " Map tab to omnicompletion
Plug 'folke/which-key.nvim'
Plug 'karb94/neoscroll.nvim'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'ntpeters/vim-better-whitespace' " causes all trailing whitespace characters to be highlighted, :StripWhitespace to clean
Plug 'preservim/nerdcommenter' " [count]<leader>c<space> |NERDCommenterToggle|
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'
Plug 'rhysd/git-messenger.vim' " :GitMessenger or <Leader>gm, d show diff of file, D show diff of commit, o/O prev/next commit history
Plug 'tpope/vim-sensible'
Plug 'vim-airline/vim-airline' " Lean & mean status/tabline for vim that's light as air

" Terminals
Plug 'tpope/vim-dispatch' " Dep for vim-jack-in and vim-dispatch-neovim
Plug 'radenling/vim-dispatch-neovim' " Dep for vim-jack-in, causing a huge terminal to appear, unless you add !, eg Start!
Plug 'Olical/aniseed' "Dep for nterm
Plug 'jlesquembre/nterm.nvim'

" Telescope dependancies
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.nvim' "All the lua functions I don't want to write twice
Plug 'BurntSushi/ripgrep'
Plug 'gbprod/yanky.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope.nvim'

" Languages
Plug 'williamboman/nvim-lsp-installer' " :LspInstallInfo
Plug 'neovim/nvim-lspconfig' " brew install clojure-lsp/brew/clojure-lsp-native
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'hrsh7th/nvim-cmp' " Autocompletion plugin
Plug 'hrsh7th/cmp-nvim-lsp' " LSP source for nvim-cmp
Plug 'saadparwaiz1/cmp_luasnip' " Snippets source for nvim-cmp
Plug 'L3MON4D3/LuaSnip' " Snippets plugin

" Clojure
Plug 'liquidz/vim-iced', {'for': 'clojure'}
Plug 'liquidz/vim-iced-kaocha'
Plug 'guns/vim-sexp',    {'for': 'clojure'} " Dep for vim-sexp-mappings-for-regular-people
"Plug 'tpope/vim-sexp-mappings-for-regular-people' " >), <), >(, and <( to slurp and barf
Plug 'luochen1990/rainbow'
" Plug 'clojure-vim/vim-jack-in' " Jack in to Boot, Clj & Leiningen from Vim, run :Clj! [args], not needed if using vim-iced
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Dep for vim-iced
call plug#end()



set clipboard=unnamedplus " Automatically use the system clipboard for copy and paste, unnamed is for Linux selection register
"set completeopt=noinsert,menuone,noselect " Modifies the auto-complete menu to behave more like an IDE.
set cursorline " Highlights the current line in the editor
set expandtab
set hidden " Hide unused buffers so any buffer can be hidden (keeping its changes) without first writing the buffer to a file
set ignorecase
set inccommand=split " Show replacements in a split screen
set mouse=a " Allow to use the mouse in the editor
set nocompatible
set number " Shows the line numbers
set shiftwidth=2
set smartcase
set smartindent
set splitbelow splitright " Change the split screen behavior
set tabstop=2
set timeoutlen=400 " nvim setting for pop timeout, used by WhichKey
set title " Show file title
set ttyfast " Speed up scrolling in Vim
set wildmenu " Show a more advance menu
" 5 ones below are mentioned in vim-sensible
"set backspace=indent,eol,start
"set autoindent " Indent a new line
"set spell " enable spell check (may need to download language package)
"syntax on
"filetype plugin indent on   " Allow auto-indenting depending on file type

set viminfo='1000,f1 "save bookmarks between sessions, use uppercase or numeric marks

nnoremap <leader>d <leader>_d
"Use the "black hole register", "_ to really delete something
"noremap <Ctrl-.> @:<CR> " Use . to repeat a normal/insert-mode command, @: to repeat a command-line command
"further repeats can be done with @@
tnoremap <Esc> <C-\><C-n> " To get out of Terminal mode using esc
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR> " search for the word under the cursor or visually selected text, just press *.
noremap <Leader>y "+y " + uses CLIPBOARD; mnemonic: CTRL PLUS C (for the common keybind)
noremap <Leader>p "+p
noremap <Leader>Y "*y " * uses PRIMARY; mnemonic: Star is Select (for copy-on-select)
noremap <Leader>P "*p

map <Leader>/ :noh <CR> " Clear search highlighting

function! Path_to_kaocha_scenario()
  s'test/decisioning/scenario/features/'' | s'.feature'' | s'/'.'g | s'_'-'g
endfunction

function! Open_repl()
  "Clj!
  " Using vim-dispatch
  Start! ~/.vim/plugged/vim-iced/bin/iced repl --with-kaocha
endfunction
autocmd FileType clojure, nnoremap <leader>rrr :call Open_repl()<CR>

" vim-airline
let g:airline#extensions#tabline#enabled = 1

" rainbow
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

" vim-rhubarb
" Open current line in the browser
nnoremap <Leader>gb :.GBrowse<CR>
" Open visual selection in the browser
vnoremap <Leader>gb :GBrowse<CR>

" Telescope
nnoremap <leader>f' <cmd>lua require('telescope.builtin').marks()<cr>
nnoremap <leader>f; <cmd>lua require('telescope.builtin').builtin()<cr>
nnoremap <leader>fa <cmd>lua require('telescope.builtin').lsp_code_actions()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fd <cmd>lua require('telescope.builtin').lsp_definitions()<cr>
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files({hidden = true})<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fi <cmd>lua require('telescope.builtin').lsp_implementations()<cr>
nnoremap <leader>fj <cmd>lua require('telescope.builtin').jumplist()<cr>
nnoremap <leader>fl <cmd>lua require('telescope.builtin').loclist()<cr>
nnoremap <leader>fp <cmd>lua require('telescope.builtin').registers()<cr>
nnoremap <leader>fq <cmd>lua require('telescope.builtin').quickfix()<cr>
nnoremap <leader>fr <cmd>lua require('telescope.builtin').lsp_references()<cr>
nnoremap <leader>ft <cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>
nnoremap <leader>fw <cmd>lua require('telescope.builtin').grep_string()<cr>

nnoremap <leader>fhg <cmd>lua require('telescope.builtin').pickers()<cr>
nnoremap <leader>fhh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>fhm <cmd>lua require('telescope.builtin').man_pages()<cr>
nnoremap <leader>fh/ <cmd>lua require('telescope.builtin').search_history()<cr>
nnoremap <leader>fhk <cmd>lua require('telescope.builtin').keymaps()<cr>
nnoremap <leader>fhc <cmd>lua require('telescope.builtin').commands()<cr>

nnoremap <leader>fn <cmd>lua require('telescope').extensions.nterm.nterm()<cr>

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
"let g:sexp_filetypes = ''
"let g:sexp_enable_insert_mode_mappings = 0

" vim-iced
" Enable vim-iced's default key mapping
let g:iced_enable_default_key_mappings = v:true
nmap <Leader>> <Plug>(iced_slurp)
nmap <Leader>< <Plug>(iced_barf)
nmap <Leader>eP <Plug>(iced_eval_and_print)<Plug>(sexp_outer_list)``
nmap <Leader>ewt <Plug>(iced_eval_and_tap)<Plug>(sexp_outer_list)``
nmap <Leader>ewc <Plug>(iced_eval_and_comment)<Plug>(sexp_outer_list)``

" supertab
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

" LUA code
lua << EOF


-- nvim-lsp-installer
require("nvim-lsp-installer").setup {
  automatic_installation = true
}

-- lspconfig
vim.lsp.set_log_level("debug")
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
-- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
-- Mappings.
-- See `:help vim.lsp.*` for documentation on any of the below functions
vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {"eslint",
                 "flow",
                 "tsserver",
                 "vimls",
                 "clojure_lsp",
                 "prismals",
                 "solargraph"}
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
      },
    capabilities = capabilities
    }
end

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

-- neoscroll
require('neoscroll').setup()

-- which-key
require("which-key").setup{}

-- yanky
require("yanky").setup({})
vim.keymap.set("n", "p", "<Plug>(YankyPutAfter)", {})
vim.keymap.set("n", "P", "<Plug>(YankyPutBefore)", {})
vim.keymap.set("x", "p", "<Plug>(YankyPutAfter)", {})
vim.keymap.set("x", "P", "<Plug>(YankyPutBefore)", {})
vim.keymap.set("n", "gp", "<Plug>(YankyGPutAfter)", {})
vim.keymap.set("n", "gP", "<Plug>(YankyGPutBefore)", {})
vim.keymap.set("x", "gp", "<Plug>(YankyGPutAfter)", {})
vim.keymap.set("x", "gP", "<Plug>(YankyGPutBefore)", {})
vim.api.nvim_set_keymap("n", "<c-n>", "<Plug>(YankyCycleForward)", {})
vim.api.nvim_set_keymap("n", "<c-p>", "<Plug>(YankyCycleBackward)", {})

-- Telescope
require('telescope').setup{
defaults = {
  mappings = {
    i = {
      -- map actions.which_key to <C-h> (default: <C-/>)
      -- actions.which_key shows the mappings for your picker,
      -- e.g. git_{create, delete, ...}_branch for the git_branches picker
      ["<C-h>"] = "which_key",
      }
    },
  cache_picker = {
    num_pickers = -1,
    },
  },
extensions = {
  fzf = {
    fuzzy = true,                    -- false will only do exact matching
    override_generic_sorter = true,  -- override the generic sorter
    override_file_sorter = true,     -- override the file sorter
    case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    },
  },
}
require('telescope').load_extension('fzf')
require("telescope").load_extension("yank_history")

-- Treesitter
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = {"bash",
                      "clojure",
                      "dockerfile",
                      "javascript",
                      "json",
                      "lua",
                      "python" ,
                      "ruby",
                      "vim",
                      "yaml"},
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

-- nterm
-- currently broken because of aniseed
require'nterm.main'.init({
  maps = false,  -- load defaut mappings
  shell = "zsh",
  size = 20,
  direction = "horizontal", -- horizontal or vertical
  popup = 2000,     -- Number of miliseconds to show the info about the commmand. 0 to dissable
  popup_pos = "SE", --  one of "NE" "SE" "SW" "NW"
  autoclose = 2000, -- If command is sucesful, close the terminal after that number of miliseconds. 0 to disable
})
-- vim.api.nvim_set_keymap( "n", "<leader>aa", "<cmd>lua require'nterm.main'.term_toggle()<cr>", opts)
-- vim.api.nvim_set_keymap( "n", "<leader>at", "<cmd>lua require'nterm.main'.term_focus()<cr>", opts)
-- vim.api.nvim_set_keymap( "n", "<leader>af", "<cmd>lua require'nterm.main'.term_focus('repl')<cr>", opts)
-- vim.api.nvim_set_keymap( "n", "<leader>ar", "<cmd>lua require'nterm.main'.term_send('~/.vim/plugged/vim-iced/bin/iced repl --with-kaocha', 'repl')<cr>", opts)
-- vim.api.nvim_set_keymap( "n", "<leader>al", "<cmd>lua require'nterm.main'.term_send_cur_line(nil, {autoclose=0})<cr>", opts)
vim.api.nvim_set_keymap( "n", "<leader>ar", "<cmd>terminal ~/.vim/plugged/vim-iced/bin/iced repl --with-kaocha <cr>", opts)
require('telescope').load_extension('nterm')

EOF
