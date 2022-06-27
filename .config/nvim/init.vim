" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged' " - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.config/nvim/plugged')

" nvim 0.5 specific
" Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'

" Extensions to built-in LSP, for example, providing type inlay hints
Plug 'tjdevries/lsp_extensions.nvim'

" Autocompletion framework for built-in LSP
Plug 'hrsh7th/nvim-cmp'

" LSP completion source for nvim-cmp
Plug 'hrsh7th/cmp-nvim-lsp'

" Snippet completion source for nvim-cmp
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" Other usefull completion sources
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

" Diagnostic navigation and settings for built-in LSP
" Plug 'nvim-lua/diagnostic-nvim'

" Debugger DAP protocol integration
" Plug 'mfussenegger/nvim-dap'

" Plug 'morhetz/gruvbox'
Plug 'lifepillar/vim-gruvbox8'

Plug 'simrat39/rust-tools.nvim'

" Optional dependencies
" Plug 'nvim-lua/popup.nvim'
" Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-telescope/telescope.nvim'


" nvim 0.4+
Plug 'rstacruz/vim-closer'
Plug 'junegunn/vim-easy-align' 
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Plug 'scrooloose/nerdtree'
" Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
Plug 'vim-airline/vim-airline'

Plug 'machakann/vim-highlightedyank'
" Plug 'fatih/molokai'

Plug 'dag/vim-fish'
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'

Plug 'tpope/vim-commentary'

Plug 'cespare/vim-toml'
" Initialize plugin system
call plug#end()

let g:rooter_patterns = ['.git/'] ", 'Cargo.toml', '.git/']

"colorscheme molokai
"hi Comment guifg=#bababa
set termguicolors
" let g:gruvbox_italic=1
" let g:gruvbox_contrast_dark="hard"
" set background=dark
" colorscheme gruvbox8
let g:gruvbox_plugin_hi_groups = 1
let g:gruvbox_filetype_hi_groups = 1
colorscheme gruvbox8_hard

" hi! link DiagnosticError GruvboxRed
" hi! link DiagnosticWarning GruvboxOrange
" hi! link DiagnosticInformation GruvboxYellow
" hi! link DiagnosticHint GruvboxBlue
"
hi! link DiagnosticUnderlineError ALEError
hi! link DiagnosticUnderlineHint ALEInfo
hi! link DiagnosticUnderlineInfo ALEInfo
hi! link DiagnosticUnderlineWarning ALEWarning

" Gruvbox
" hi! link DiagnosticVirtualTextError GruvboxRed
" hi! link DiagnosticVirtualTextWarning GruvboxOrange
" hi! link DiagnosticVirtualTextInformation GruvboxYellow
" hi! link DiagnosticVirtualTextHint GruvboxBlue

" Gruvbox8
hi! link DiagnosticVirtualTextError CocErrorFloat
hi! link DiagnosticVirtualTextWarning CocWarningFloat
hi! link DiagnosticVirtualTextInformation CocInfoFloat
hi! link DiagnosticVirtualTextHint CocHintFloat

" Gruvbox8 signs
sign define DiagnosticSignError text=✘ texthl=CocErrorSign linehl= numhl=
sign define DiagnosticSignWarning text=» texthl=CocWarningSign linehl= numhl=
sign define DiagnosticSignInformation text=ⓘ texthl=CocInfoSign linehl= numhl=
sign define DiagnosticSignHint text=► texthl=CocHintSign linehl= numhl=

" Gruvbox signs
" sign define DiagnosticSignError text=✘ texthl=GruvboxRedSign linehl= numhl=GruvboxRed
" sign define DiagnosticSignWarning text=» texthl=GruvboxYellowSign linehl= numhl=GruvboxOrange
" sign define DiagnosticSignInformation text=ⓘ texthl=GruvboxBlueSign linehl= numhl=GruvboxBlue
" sign define DiagnosticSignHint text=► texthl=GruvboxAquaSign linehl= numhl=GruvboxAqua

" LSP configuration 0.5 specific
" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

" Configure LSP
" https://github.com/neovim/nvim-lspconfig#rust_analyzer

lua <<EOF

-- lspconfig object
local lspconfig = require'lspconfig'

-- function to attach completion and diagnostics
-- when setting up lsp
local on_attach = function(client)
    require'completion'.on_attach(client)
    -- vim.api.nvim_command("au BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)")
end

require'nvim-treesitter.configs'.setup {
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    -- disable = { "c", "rust" },  -- list of language that will be disabled
  },
}

-- function keeps the cursor where it should be even if somehow this formatting calls moves it
function format_rust()
    local lineno = vim.api.nvim_win_get_cursor(0)
    vim.lsp.buf.formatting_sync(nil, 1000)
    vim.api.nvim_win_set_cursor(0, lineno)
end

local util = require 'lspconfig/util'

-- Enable rust_analyzer
--lspconfig.rust_analyzer.setup({ on_attach=on_attach,
--    root_dir = util.root_pattern(".git", "rust-project.json");
--    settings = {
--        ["rust-analyzer"] = {
--            assist = {
--                importGranularity = "module",
--                importPrefix = "by_self",
--            },
--            procMacro = {
--                enable = true,
--            },
--            cargo = {
--                loadOutDirsFromCheck = true,
--            },
--            updates = {
--                channel = "nightly",
--            },
--        },
--    },
--})

function go_organize_imports_sync(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = {only = {"source.organizeImports"}}
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit, "utf-16")
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end


-- function org_imports()
--   local clients = vim.lsp.buf_get_clients()
--   for _, client in pairs(clients) do
-- 
--     local params = vim.lsp.util.make_range_params(nil, client.offset_encoding)
--     params.context = {only = {"source.organizeImports"}}
-- 
--     local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 5000)
--     for _, res in pairs(result or {}) do
--       for _, r in pairs(res.result or {}) do
--         if r.edit then
--           vim.lsp.util.apply_workspace_edit(r.edit, client.offset_encoding)
--         else
--           vim.lsp.buf.execute_command(r.command)
--         end
--       end
--     end
--   end
-- end
-- 
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = { "*.go" },
--   callback = vim.lsp.buf.format,
-- })
-- 
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = { "*.go" },
--   callback = org_imports,
-- })


-- Enable gopls
lspconfig.gopls.setup{{ on_attach=on_attach,
    cmd = {"gopls", "serve"},
    settings = {
      gopls = {
       -- completeUnimported = true,
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
      },
    },
}}

lspconfig.jsonls.setup{}
lspconfig.terraformls.setup{}
lspconfig.html.setup{}
lspconfig.clangd.setup{}


local opts = {
    tools = { -- rust-tools options
        -- automatically set inlay hints (type hints)
        -- There is an issue due to which the hints are not applied on the first
        -- opened file. For now, write to the file to trigger a reapplication of
        -- the hints or just run :RustSetInlayHints.
        -- default: true
        autoSetHints = true,

        -- whether to show hover actions inside the hover window
        -- this overrides the default hover handler
        -- default: true
        hover_with_actions = true,

        runnables = {
            -- whether to use telescope for selection menu or not
            -- default: true
            -- use_telescope = true

            -- rest of the opts are forwarded to telescope
        },

        inlay_hints = {
            -- wheter to show parameter hints with the inlay hints or not
            -- default: true
            show_parameter_hints = true,

            -- prefix for parameter hints
            -- default: "<-"
            parameter_hints_prefix = "<-",

            -- prefix for all the other hints (type, chaining)
            -- default: "=>"
            other_hints_prefix  = "=>",
        },

        hover_actions = {
            -- the border that is used for the hover window
            -- see vim.api.nvim_open_win()
            border = {
              {"╭", "FloatBorder"},
              {"─", "FloatBorder"},
              {"╮", "FloatBorder"},
              {"│", "FloatBorder"},
              {"╯", "FloatBorder"},
              {"─", "FloatBorder"},
              {"╰", "FloatBorder"},
              {"│", "FloatBorder"}
            },
        }
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
    server = {
      settings = {
        ["rust-analyzer"] = {
            assist = {
                importGranularity = "module",
                importPrefix = "by_self",
            },
            cargo = {
                loadOutDirsFromCheck = true
            },
            procMacro = {
                enable = true
            },
            checkOnSave = {
                command = "clippy"
            },
        }
      }
    }, -- rust-analyer options
}

require('rust-tools').setup(opts)
--require('telescope').setup{
--  defaults = {
--    file_ignore_patterns = {"%.gz"},
--  }
--}


-- Setup Completion
-- See https://github.com/hrsh7th/nvim-cmp#basic-configuration
local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'buffer' },
  },
})

cmp.setup.filetype('markdown', {
  enabled=false,
})

EOF
"" End of LSP config

set signcolumn=yes
set nocompatible                " choose no compatibility with legacy vi
syntax enable
set encoding=utf-8
set showcmd                     " display incomplete commands

"" Whitespace
set nowrap                      " don't wrap lines
set tabstop=4
set shiftwidth=4                " a tab is two spaces (or set this to 4)
set expandtab                   " use spaces, not tabs (optional)
set backspace=indent,eol,start  " backspace through everything in insert mode
set textwidth=9999

set mouse=a               " allow mouse usage

"" Various
set ruler                " show position in status line
if has("gui_running")
    set cursorline           " highlight current line
end
set number
set relativenumber               " line numbers
set nofoldenable
set list                 " show invisible chars
set listchars=tab:▸\ ,eol:¬,trail:·,extends:»,precedes:«,nbsp:·
set scrolloff=10         " unless not possible, don't reach the last line before scrolling
set sidescrolloff=10
set visualbell           " no sound
set t_vb=                " and no sound
"set antialias            " better font
set clipboard=unnamed    " Use the system clipboard
set laststatus=2         " basically enable vim status line
set autoread             " autoreload files when there are no unsaved changes
set hidden

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

set wildmenu                    " help with autocomplete commands
set wildmode=list:longest,full
set showmatch                   " show paren matching
set mat=5                       " change duration of show

"" permanent undo
set undodir=~/.vimdid
set undofile

"" Better splits
set splitright
set splitbelow

"" no backups
set nobackup
set nowritebackup
set noswapfile

"" wrapping options http://vimdoc.sourceforge.net/htmldoc/change.html#fo-table
set formatoptions=tc
set formatoptions+=r
set formatoptions+=o
set formatoptions+=q
set formatoptions+=n
set formatoptions+=b

"set backupdir=~/.vim/_backup    " where to put backup files.
set directory=~/.vim/_temp      " where to put swap files.

"" use comma as <Leader> key instead of backslash
" let mapleader=","

"" double percentage sign in command mode is expanded
"" to directory of current file - http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" Go back to previous buffer
nnoremap <leader><leader> <c-^>
"nmap ; :
noremap <space> :
"nnoremap ; :
"nnoremap : ;

" Change buffer in the current split
map <m-d-left> :bp<cr>
map <m-d-right> :bn<cr>

" Map Escape
imap <c-L> <Esc>

" Remap convenient vertical/horizontal split
map <leader>s :split<cr>
map <leader>v :vsplit<cr>
map <leader>u <c-w>q
map <leader>U <c-w><c-o>

" Remap auto-pairs
map <leader>k <m-p>
map <leader>n <m-n>

" Remap window close but don't delete buffer
map `` :q<cr>
map <leader>`` :q!<cr>
" Remap buffer delete
map <leader>bd :bd<cr>
map <leader>BD :bd!<cr>

" Remap moving between splits
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" build cargo
nnoremap <leader>c :Cbuild<cr>
" run cargo
nnoremap <leader>e :Crun<cr>

" when in terminal mode, leave terminal mode with simple ESC key
tnoremap <Esc> <C-\><C-n>

" take out the toolbar
set guioptions-=T

" NerdTree
" map t :NERDTreeToggle<CR>
"nnoremap t <cmd>CHADopen<cr>

" " Open nerdtree when vim opened on directory
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" Wrap in certain cases.
function! s:setupWrapping()
    set wrap
    set wrapmargin=2
    set textwidth=120
    set tabstop=2
    set shiftwidth=2
endfunction

"" Some variants
" In Makefiles, use real tabs, not tabs expanded to spaces
au FileType make set noexpandtab

au FileType rust set expandtab
au FileType rust set tabstop=4
au FileType rust set shiftwidth=4
" disable vim-closer when in a rust file, rust-analyzer already closes parens automatically
au FileType rust let b:closer=0

" Make sure all markdown files have the correct filetype set and setup wrapping
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} set filetype=markdown | call s:setupWrapping()
let g:vim_markdown_new_list_item_indent = 2
let g:markdown_fenced_languages = ['html', 'vim', 'ruby', 'python', 'bash=sh', 'rust', 'go']

" Remember last location in file, but not for commit messages.
" see :help last-position-jump
au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
            \| exe "normal! g`\"" | endif

autocmd BufWritePre *.rs lua format_rust()
autocmd BufWritePre *.go :silent! lua go_organize_imports_sync(1000)
autocmd BufWritePre *.go :silent! lua vim.lsp.buf.formatting()


" set of files for which we'll spell check
augroup spellcheck_documentation
  autocmd BufNewFile,BufRead *.md setlocal spell
  autocmd BufNewFile,BufRead *.rdoc setlocal spell
augroup END

function! LspStatus() abort
    let sl = ''
    if luaeval('not vim.tbl_isempty(vim.lsp.buf_get_clients(0))')
        let sl.='%#MyStatuslineLSP#E:'
        let sl.='%#MyStatuslineLSPErrors#%{luaeval("vim.lsp.util.buf_diagnostics_count([[Error]])")}'
        let sl.='%#MyStatuslineLSP# W:'
        let sl.='%#MyStatuslineLSPWarnings#%{luaeval("vim.lsp.util.buf_diagnostics_count([[Warning]])")}'
    else
        let sl.='%#MyStatuslineLSPErrors#off'
    endif
    return sl
endfunction
let &l:statusline = '%#MyStatuslineLSP#LSP '.LspStatus()

" don't use Ex mode, use Q for formatting
map Q gq

" clear the search buffer when hitting return
nnoremap <CR> :nohlsearch<cr>

" turn on tagbar
"nmap m :TagbarToggle<CR>

" No idea what this does but nobody should care about .pyc files
set wildignore+=*.pyc

" Get rid of extra white space
command! KillWhitespace :normal :%s/ *$//g<cr><c-o><cr>

" vim-python-combined with all highlights
let python_highlight_all=1

" w!! if you forget to sudo before saving
cmap w!! w !sudo tee % >/dev/null
function WriteCreatingDirs()
    execute ':silent !mkdir -p %:h'
    write
endfunction
command W call WriteCreatingDirs()

" map the buffer list
"map ; :ls<CR>

" bernie: search for highlighted text
:vmap // y/<C-R>"<CR>




" change directory
command! Adroll :lcd ~/dev/Adroll/adroll
command! Dyno :lcd ~/dev/Adroll/dyno
command! S3cripts :lcd ~/dev/Adroll/s3scripts
command! Kinetic :lcd ~/dev/Adroll/kinetic

nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Left and right can switch buffers
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>


" " Find files using Telescope command-line sugar.
" nmap <leader>p <cmd>Telescope find_files<cr>
" nmap <leader>fg <cmd>Telescope live_grep<cr>
" nmap <leader>fb <cmd>Telescope buffers<cr>
" nmap <leader>fh <cmd>Telescope help_tags<cr>
set rtp+=/opt/homebrew/bin/fzf
nmap ; :Buffers<CR>
nmap <Leader>p :Files<CR>
nmap <Leader>l :Lines<CR>
" <leader>s for Rg search
noremap <leader>g :Rg<CR>
let g:fzf_layout = { 'down': '~20%' }
command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
            \   <bang>0 ? fzf#vim#with_preview('up:60%')
            \           : fzf#vim#with_preview('right:50%:hidden', '?'),
            \   <bang>0)


" piro: fix broken Page Up/Down
" http://vimrc-dissection.blogspot.com/2009/02/fixing-pageup-and-pagedown.html
map <silent> <PageUp> 1000<C-U>
map <silent> <PageDown> 1000<C-D>
imap <silent> <PageUp> <C-O>1000<C-U>
imap <silent> <PageDown> <C-O>1000<C-D>
set nostartofline
filetype plugin indent on       " load file type plugins + indentation


" END LSP

"set macligatures
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
if has('gui_running')
    "set guifont=Source\ Code\ Pro\ Medium\ for\ Powerline:h14
    set guifont=FiraCode\ Retina\ Nerd\ Font:h13
    "set guifont=FiraCode\ Retina:h13
    "set guifont=Sauce\ Code\ Powerline\ Light:h11
    "python from powerline.vim import setup as powerline_setup
    "python powerline_setup()
    "python del powerline_setup
endif

" Movements in insert mode
"single movements h j k l
noremap! <Leader>h <left>
noremap! <Leader>j <down>
noremap! <Leader>k <up>
noremap! <Leader>l <right>
"append shortcuts
noremap! <Leader>A <esc>A
noremap! <Leader>a <esc>a
"new line and insert shortcuts
noremap! <Leader>O <esc>O
noremap! <Leader>o <esc>o


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 'Smart' nevigation
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.

" this next config parameter is only needed because of a conflict between
" vim-closer and completion-nvim on the usage of <CR> mapping.
" let g:completion_confirm_key = ""
" inoremap <silent><expr> <TAB>
"            \ pumvisible() ? "\<C-n>" :
"            \ <SID>check_back_space() ? "\<TAB>" :
"            \ completion#trigger_completion()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Code navigation shortcuts
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
inoremap <silent> <c+k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gT    <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> rn    <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

" Visualize diagnostics
:lua << EOF
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- This will disable virtual text, like doing:
    -- let g:diagnostic_enable_virtual_text = 0
    virtual_text = true,

    -- This is similar to:
    -- let g:diagnostic_show_sign = 1
    -- To configure sign display,
    --  see: ":help vim.lsp.diagnostic.set_signs()"
    signs = true,

    -- This is similar to:
    -- "let g:diagnostic_insert_delay = 1"
    update_in_insert = false,
  }
)
EOF

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=1000
" Show diagnostic popup on cursor hold
autocmd CursorHold * lua vim.diagnostic.open_float()

" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
   let @/ = ''
   if exists('#auto_highlight')
     au! auto_highlight
     augroup! auto_highlight
     setl updatetime=4000
     echo 'Highlight current word: off'
     return 0
  else
    augroup auto_highlight
    au!
    au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
    augroup end
    setl updatetime=500
    echo 'Highlight current word: ON'
  return 1
 endif
endfunction


" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.diagnostic.goto_next()<CR>

" autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
"            \ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment", enabled = { "ChainingHint", "TypeHint", "ParameterHint"} }


" Tabularize
if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
endif
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction




" Put these lines at the very end of your vimrc file.

" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL
