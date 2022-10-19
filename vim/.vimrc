" vimrc for neovim
" Autor: nizarion
" vim -V20 2>&1 | tee logfile (debugging vimrc)

" Theme - coloscheme
"let g:gruvbox_contrast_dark = 'hard' " available values: 'hard', 'medium'(default), 'soft'
"set background=dark " or light if you want light mode
"autocmd vimenter * ++nested colorscheme onedark
" gruvbox onedark molokai papercolor

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
Plug 'navarasu/onedark.nvim'
Plug 'tomasr/molokai'
Plug 'altercation/vim-colors-solarized'
Plug 'NLKNguyen/papercolor-theme'
Plug 'kyazdani42/nvim-web-devicons' "brew tap homebrew/cask-fonts &&\nbrew install --cask font-hack-nerd-font AND change terminal font
Plug 'mhinz/vim-startify'
Plug 'folke/which-key.nvim' " :checkhealth which_key
Plug 'karb94/neoscroll.nvim'
Plug 'kyazdani42/nvim-tree.lua' " g? for key mapping
Plug 'ntpeters/vim-better-whitespace' " causes all trailing whitespace characters to be highlighted, :StripWhitespace to clean
Plug 'numToStr/Comment.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'tpope/vim-sensible'
Plug 'wfxr/minimap.vim' " brew install code-minimap

" Git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb' " Open current line in github
Plug 'airblade/vim-gitgutter'
Plug 'rhysd/git-messenger.vim' " :GitMessenger or <Leader>gm, d show diff of file, D show diff of commit, o/O prev/next commit history
Plug 'sindrets/diffview.nvim' " :h diffview-merge-tool for keymap

" Terminals
Plug 'tpope/vim-dispatch' " Dep for vim-jack-in and vim-dispatch-neovim
Plug 'radenling/vim-dispatch-neovim' " Dep for vim-jack-in, causing a huge terminal to appear, unless you add !, eg Start!

" Telescope dependancies
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.nvim' "All the lua functions I don't want to write twice
Plug 'BurntSushi/ripgrep'
Plug 'gbprod/yanky.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-ui-select.nvim'
Plug 'fannheyward/telescope-coc.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Languages
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'towolf/vim-helm'
"Plug 'williamboman/nvim-lsp-installer' " :LspInstallInfo
"Plug 'neovim/nvim-lspconfig' " brew install clojure-lsp/brew/clojure-lsp-native
"Plug 'hrsh7th/nvim-cmp' " Autocompletion plugin
"Plug 'hrsh7th/cmp-nvim-lsp' " LSP source for nvim-cmp
"Plug 'saadparwaiz1/cmp_luasnip' " Snippets source for nvim-cmp
"Plug 'L3MON4D3/LuaSnip' " Snippets plugin

" Clojure
Plug 'Olical/conjure'
Plug 'Invertisment/conjure-clj-additions-cider-nrepl-mw'
"Plug 'liquidz/vim-iced', {'for': 'clojure'}
"Plug 'liquidz/vim-iced-kaocha', {'for': 'clojure'}
"Plug 'liquidz/vim-iced-coc-source', {'for': 'clojure'}
Plug 'guns/vim-sexp' ", {'for': 'clojure'} Dep for vim-sexp-mappings-for-regular-people
Plug 'tpope/vim-sexp-mappings-for-regular-people' " >), <), >(, and <( to slurp and barf
Plug 'tpope/vim-surround' " To remove the delimiters entirely, press ds. cs[' to replace [ with '. In visual mode, a simple S with an argument wraps the selection.
Plug 'tpope/vim-repeat'

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
set viminfo='1000,f1 "save bookmarks between sessions, use uppercase or numeric marks
set termguicolors " this variable must be enabled for colors to be applied properly from nvim-tree

let mapleader = "\\"
let maplocalleader = ";"

" window management
" Ctrl-w t makes the first (topleft) window current
" Ctrl-w H moves the current window to full-height at far left
" Ctrl-w K moves the current window to full-width at the very top


nnoremap <leader>d <leader>_d
"Use the "black hole register", "_ to really delete something
"noremap <Ctrl-.> @:<CR> " Use . to repeat a normal/insert-mode command, @: to repeat a command-line command
"further repeats can be done with @@
tnoremap <Esc> <C-\><C-n> " To get out of Terminal mode using esc
"vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR> " search for the word under the cursor or visually selected text, just press *.
noremap <Leader>y "+y " + uses CLIPBOARD; mnemonic: CTRL PLUS C (for the common keybind)
noremap <Leader>p "+p
noremap <Leader>Y "*y " * uses PRIMARY; mnemonic: Star is Select (for copy-on-select)
noremap <Leader>P "*p
" Clear search highlighting
noremap <Leader>/ :noh<CR>

" Buffer switching
nnoremap <silent> <C-A> :bn<CR>
nnoremap <silent> <C-S-A> :bp<CR>

" God help me with typos
command WQ wq
command Wq wq
command W w
command Q q

" Custom Languages
" Starlark
au! BufRead,BufNewFile *.star setfiletype python

" rainbow
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

" vim-rhubarb
" Open current line in the browser
nnoremap <Leader>gb :.GBrowse<CR>
" Open visual selection in the browser
vnoremap <Leader>gb :GBrowse<CR>

" Nvim-tree
nnoremap <leader>n :NvimTreeToggle<CR>

" startify
let g:startify_change_to_dir = 0

" vim-sexp
" Disable mapping hooks
"let g:sexp_filetypes = ''
"let g:sexp_enable_insert_mode_mappings = 0

" vim-iced
"let g:iced_enable_default_key_mappings = v:true
"nmap <Leader>> <Plug>(iced_slurp)
"nmap <Leader>< <Plug>(iced_barf)
"nmap <Leader>eP <Plug>(iced_eval_and_print)<Plug>(sexp_outer_list)``
"nmap <Leader>ewt <Plug>(iced_eval_and_tap)<Plug>(sexp_outer_list)``
"nmap <Leader>ewc <Plug>(iced_eval_and_comment)<Plug>(sexp_outer_list)``
"nmap <Nop>(iced_document_popup_open) <Plug>(iced_document_popup_open)

function! Open_repl()
  "Clj!
  " Using vim-dispatch
  Start! ~/.vim/plugged/vim-iced/bin/iced repl --with-kaocha
endfunction
autocmd FileType clojure, nnoremap <leader>rrr :call Open_repl()<CR>

function! Path_to_kaocha_scenario()
  s'test/decisioning/scenario/features/'' | s'.feature'' | s'/'.'g | s'_'-'g
endfunction


" conjure
let g:conjure#highlight#enabled = 1
" testing namespace ;eb ;tn
" testing current test ;er ;tc
let g:conjure#client#clojure#nrepl#connection#port_file = [".nrepl-port", ".shadow-cljs/nrepl.port"]
let g:conjure#mapping#doc_word = ['<localleader>k'] " this doc is repl (therefore context) aware
let g:conjure#client#clojure#nrepl#completion#with_context = 1

" vim-minimap
"let g:minimap_auto_start = 1
"let g:minimap_auto_start_win_enter = 1
let g:minimap_highlight_search = 1
let g:minimap_highlight_range = 1

" LUA code
" startluablock
lua << EOF
local key_map = vim.api.nvim_set_keymap
local M = {}
-- onedark
require('onedark').setup {
    style = 'dark'
}
require('onedark').load()


-- indent-blankline
-- vim.opt.list = true
-- vim.opt.listchars:append "eol:↴"
vim.opt.termguicolors = true
-- gruvbox #282828 #303030
-- onedark #31353f #282c34
vim.cmd [[highlight IndentBlanklineIndent1 guibg=#31353f gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guibg=#282c34 gui=nocombine]]

require("indent_blankline").setup {
  char = "",
  char_highlight_list = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
    },
  space_char_highlight_list = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
    },
  show_current_context = true,
  show_current_context_start = true,
  space_char_blankline = " ",
  show_current_context = true,
  show_current_context_start = true,
  show_trailing_blankline_indent = false,
  }

-- neoscroll
require('neoscroll').setup()

-- Comment.nvim
-- gcc Line-comment toggle keymap, gcA Add comment at the end of line, gco line below
require('Comment').setup()

-- which-key
require("which-key").setup{}

-- yanky
require("yanky").setup({
})
vim.keymap.set("n", "p", "<Plug>(YankyPutAfter)", {})
vim.keymap.set("n", "P", "<Plug>(YankyPutBefore)", {})
vim.keymap.set("x", "p", "<Plug>(YankyPutAfter)", {})
vim.keymap.set("x", "P", "<Plug>(YankyPutBefore)", {})
vim.keymap.set("n", "gp", "<Plug>(YankyGPutAfter)", {})
vim.keymap.set("n", "gP", "<Plug>(YankyGPutBefore)", {})
vim.keymap.set("x", "gp", "<Plug>(YankyGPutAfter)", {})
vim.keymap.set("x", "gP", "<Plug>(YankyGPutBefore)", {})
key_map("n", "<c-p>", "<Plug>(YankyCycleForward)", { noremap = true, silent = true })
key_map("n", "<c-n>", "<Plug>(YankyCycleBackward)", { noremap = true, silent = true })


-- lualine
require('lualine').setup{
tabline = {
  lualine_a = {'buffers'},
  lualine_b = {},
  lualine_c = {{'filename', path = 1 }},
  lualine_x = {},
  lualine_y = {},
  lualine_z = {'tabs'}
  },
sections = {
  lualine_a = {'mode'},
  lualine_b = {'branch', 'diff', 'diagnostics'},
  lualine_c = {'filename'},
  lualine_x = {'encoding', 'fileformat', 'filetype'},
  lualine_y = {'progress'},
  lualine_z = {'location'}
  },
inactive_sections = {
  lualine_a = {},
  lualine_b = {},
  lualine_c = {'filename'},
  lualine_x = {'location'},
  lualine_y = {},
  lualine_z = {}
  },
}

-- Telescope
require('telescope').setup{
defaults = {
  mappings = {
    n = {
      ['<c-d>'] = require('telescope.actions').delete_buffer
      },
    i = {
      -- map actions.which_key to <C-h> (default: <C-/>)
      -- actions.which_key shows the mappings for your picker,
      -- e.g. git_{create, delete, ...}_branch for the git_branches picker
      ["<C-h>"] = "which_key",
      ['<c-d>'] = require('telescope.actions').delete_buffer
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
require('telescope').load_extension('coc')
require("telescope").load_extension ("ui-select")

-- grep_string pre-filtered from grep_prompt
local function grep_filtered(opts)
  opts = opts or {}
  require("telescope.builtin").grep_string {
    path_display = { "smart" },
    search = opts.filter_word or "",
  }
end

-- open vim.ui.input dressing prompt for initial filter
function M.grep_prompt()
  vim.ui.input({ prompt = "Rg " }, function(input)
    grep_filtered { filter_word = input }
  end)
end
key_map("n", "<leader>fdg", [[<Cmd>lua require'telescope'.grep_prompt()<CR>]], { noremap = true, silent = true })

key_map("n", "<leader>f'", [[<cmd>lua require('telescope.builtin').marks()<cr>]], { noremap = true, silent = true })
key_map("n", "<leader>f;", [[<cmd>lua require('telescope.builtin').builtin()<cr>]], { noremap = true, silent = true })
key_map("n", "<leader>fa", [[<cmd>lua vim.lsp.buf.code_action()<CR>]], { noremap = true, silent = true })
key_map("n", "<leader>b",  [[<cmd>lua require('telescope.builtin').buffers()<cr>]], { noremap = true, silent = true })
key_map("n", "<leader>fd", [[<cmd>lua require('telescope.builtin').lsp_definitions()<cr>]], { noremap = true, silent = true })
key_map("n", "<leader>ff", [[<cmd>lua require('telescope.builtin').git_files({hidden = true})<cr>]], { noremap = true, silent = true })
key_map("n", "<leader>fx", [[<cmd>lua require('telescope.builtin').find_files({hidden = true})<cr>]], { noremap = true, silent = true })
key_map("n", "<leader>fg", [[<cmd>lua require('telescope.builtin').live_grep()<cr>]], { noremap = true, silent = true })
key_map("n", "<leader>fi", [[<cmd>lua require('telescope.builtin').lsp_implementations()<cr>]], { noremap = true, silent = true })
key_map("n", "<leader>fj", [[<cmd>lua require('telescope.builtin').jumplist()<cr>]], { noremap = true, silent = true })
key_map("n", "<leader>fl", [[<cmd>lua require('telescope.builtin').loclist()<cr>]], { noremap = true, silent = true })
key_map("n", "<leader>fp", [[<cmd>lua require('telescope.builtin').registers()<cr>]], { noremap = true, silent = true })
key_map("n", "<leader>fq", [[<cmd>lua require('telescope.builtin').quickfix()<cr>]], { noremap = true, silent = true })
key_map("n", "<leader>fr", [[<cmd>lua require('telescope.builtin').lsp_references()<cr>]], { noremap = true, silent = true })
key_map("n", "<leader>ft", [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>]], { noremap = true, silent = true })
key_map("n", "<leader>fw", [[<cmd>lua require('telescope.builtin').grep_string()<cr>]], { noremap = true, silent = true })

key_map("n", "<leader>fhg",[[<cmd>lua require('telescope.builtin').pickers()<cr>]], { noremap = true, silent = true })
key_map("n", "<leader>fhh",[[<cmd>lua require('telescope.builtin').help_tags()<cr>]], { noremap = true, silent = true })
key_map("n", "<leader>fhm",[[<cmd>lua require('telescope.builtin').man_pages()<cr>]], { noremap = true, silent = true })
key_map("n", "<leader>fh/",[[<cmd>lua require('telescope.builtin').search_history()<cr>]], { noremap = true, silent = true })
key_map("n", "<leader>fhk",[[<cmd>lua require('telescope.builtin').keymaps()<cr>]], { noremap = true, silent = true })
key_map("n", "<leader>fhc",[[<cmd>lua require('telescope.builtin').commands()<cr>]], { noremap = true, silent = true })

key_map("n", "<leader>fn", [[<cmd>lua require('telescope').extensions.nterm.nterm()<cr>]], { noremap = true, silent = true })

-- devicons
require'nvim-web-devicons'.setup {
 -- your personnal icons can go here (to override)
 -- you can specify color or cterm_color instead of specifying both of them
 -- DevIcon will be appended to `name`
 override = {
  zsh = {
    icon = "",
    color = "#428850",
    cterm_color = "65",
    name = "Zsh"
  }
 };
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
}

-- nvim-tree
require'nvim-tree'.setup{
  respect_buf_cwd = true,
  create_in_closed_folder = true,
  hijack_cursor = true,
  renderer = {
    highlight_git = true,
    highlight_opened_files = "all",
    indent_markers = {
      enable = true,
    },
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
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
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
}

-- diffview
require("diffview").setup({
  enhanced_diff_hl = false, -- See |diffview-config-enhanced_diff_hl|
  view = {
    merge_tool = {
      layout = "diff4_mixed",
      },
  },
})

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
                      "yaml",
                      "go",
                      "hcl",
                      },
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

-- coc
vim.g.coc_global_extensions = {'coc-json', 'coc-git', 'coc-docker', 'coc-flow', 'coc-solargraph',
       'coc-tsserver', 'coc-xml', 'coc-yaml', 'coc-clojure', 'coc-pyright', 'coc-jedi', 'coc-snippets', 'coc-go',
       'coc-pairs', 'coc-lists', 'coc-prettier', 'coc-conjure'}
-- Some servers have issues with backup files, see #649.
vim.opt.backup = false
vim.opt.writebackup = false

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.opt.updatetime = 300

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved.
vim.opt.signcolumn = "yes"

local keyset = vim.keymap.set
-- Auto complete
function _G.check_back_space()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use tab for trigger completion with characters ahead and navigate.
-- NOTE: There's always complete item selected by default, you may want to enable
-- no select by `"suggest.noselect": true` in your configuration file.
-- NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
-- other plugin before putting this into your config.
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice.
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

-- Use <c-j> to trigger snippets
keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
-- Use <c-space> to trigger completion.
keyset("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})

-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
keyset("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})

-- GoTo code navigation.
keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
keyset("n", "gr", "<Plug>(coc-references)", {silent = true})


-- Use K to show documentation in preview window.
function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end
keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})


-- Highlight the symbol and its references when holding the cursor.
vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
    group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
})


-- Symbol renaming.
keyset("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})


-- Formatting selected code.
-- keyset("x", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})
-- keyset("n", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})


-- Setup formatexpr specified filetype(s).
vim.api.nvim_create_autocmd("FileType", {
    group = "CocGroup",
    pattern = "typescript,json",
    command = "setl formatexpr=CocAction('formatSelected')",
    desc = "Setup formatexpr specified filetype(s)."
})

-- Update signature help on jump placeholder.
vim.api.nvim_create_autocmd("User", {
    group = "CocGroup",
    pattern = "CocJumpPlaceholder",
    command = "call CocActionAsync('showSignatureHelp')",
    desc = "Update signature help on jump placeholder"
})


-- Applying codeAction to the selected region.
-- Example: `<leader>aap` for current paragraph
local opts = {silent = true, nowait = true}
keyset("x", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)
keyset("n", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)

-- Remap keys for applying codeAction to the current buffer.
keyset("n", "<leader>ac", "<Plug>(coc-codeaction)", opts)


-- Apply AutoFix to problem on the current line.
keyset("n", "<leader>qf", "<Plug>(coc-fix-current)", opts)


-- Run the Code Lens action on the current line.
keyset("n", "<leader>cl", "<Plug>(coc-codelens-action)", opts)


-- Map function and class text objects
-- NOTE: Requires 'textDocument.documentSymbol' support from the language server.
keyset("x", "if", "<Plug>(coc-funcobj-i)", opts)
keyset("o", "if", "<Plug>(coc-funcobj-i)", opts)
keyset("x", "af", "<Plug>(coc-funcobj-a)", opts)
keyset("o", "af", "<Plug>(coc-funcobj-a)", opts)
keyset("x", "ic", "<Plug>(coc-classobj-i)", opts)
keyset("o", "ic", "<Plug>(coc-classobj-i)", opts)
keyset("x", "ac", "<Plug>(coc-classobj-a)", opts)
keyset("o", "ac", "<Plug>(coc-classobj-a)", opts)


-- Remap <C-f> and <C-b> for scroll float windows/popups.
---@diagnostic disable-next-line: redefined-local
local opts = {silent = true, nowait = true, expr = true}
keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
keyset("i", "<C-f>",
       'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
keyset("i", "<C-b>",
       'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)


-- Use CTRL-S for selections ranges.
-- Requires 'textDocument/selectionRange' support of language server.
keyset("n", "<C-s>", "<Plug>(coc-range-select)", {silent = true})
keyset("x", "<C-s>", "<Plug>(coc-range-select)", {silent = true})


-- Add `:Format` command to format current buffer.
vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

-- " Add `:Fold` command to fold current buffer.
vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", {nargs = '?'})

-- Add `:OR` command for organize imports of the current buffer.
vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

-- Add (Neo)Vim's native statusline support.
-- NOTE: Please see `:h coc-status` for integrations with external plugins that
-- provide custom statusline: lightline.vim, vim-airline.
vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

-- Mappings for CoCList
-- code actions and coc stuff
---@diagnostic disable-next-line: redefined-local
local opts = {silent = true, nowait = true}
-- Show all diagnostics.
keyset("n", "<space>a", ":<C-u>CocList diagnostics<cr>", opts)
-- Manage extensions.
keyset("n", "<space>e", ":<C-u>CocList extensions<cr>", opts)
-- Show commands.
keyset("n", "<space>c", ":<C-u>CocList commands<cr>", opts)
-- Find symbol of current document.
keyset("n", "<space>o", ":<C-u>CocList outline<cr>", opts)
-- Search workspace symbols.
keyset("n", "<space>s", ":<C-u>CocList -I symbols<cr>", opts)
-- Do default action for next item.
keyset("n", "<space>j", ":<C-u>CocNext<cr>", opts)
-- Do default action for previous item.
keyset("n", "<space>k", ":<C-u>CocPrev<cr>", opts)
-- Resume latest coc list.
keyset("n", "<space>p", ":<C-u>CocListResume<cr>", opts)
return M
EOF
" endluablock

" Coc
" https://github.com/neoclide/coc-snippets
" To install prettier in your project and pin its version as recommended, run:
" npm install prettier -D --save-exact

