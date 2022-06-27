local set = vim.opt
local g = vim.g

if vim.fn.has('termguicolors') == 1 then
    set.termguicolors = true
    vim.g.gruvbox_plugin_hi_groups = true
    vim.g.gruvbox_filetype_hi_groups = true
    vim.cmd('colorscheme gruvbox8_hard')
end

vim.cmd[[
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
]]


set.signcolumn='yes'
vim.cmd('syntax enable')
set.encoding='utf-8'
set.showcmd=true

set.wrap=false

set.tabstop=4
set.softtabstop=4
set.shiftwidth=4
set.expandtab=true
set.backspace = "indent,eol,start"
set.textwidth = 9999

set.mouse = 'a'
set.ruler = true

set.cursorline=true
set.number=true
set.relativenumber=true

set.foldenable=false
set.list=true
set.listchars = {tab = "▸ ", eol = "¬", trail = "·", extends = "»", precedes = "«", nbsp = "·"}

set.scrolloff=10
set.sidescrolloff=10
set.visualbell=true
vim.cmd("set t_vb=")

set.clipboard="unnamed"
set.laststatus=2
set.autoread=true
set.hidden=true

set.hlsearch=true    -- highlight matches
set.incsearch=true   -- incremental searching
set.ignorecase=true  -- searches are case insensitive...
set.smartcase=true   -- ... unless they contain at least one capital letter


set.wildmenu=true
set.wildmode= {"longest", "full"}
set.showmatch=true
set.mat=5

set.undodir="/Users/dialtone/.vimdid"
set.undofile=true

set.splitright=true
set.splitbelow=true

-- no backups
set.backup = false
set.writebackup = false
set.swapfile = false

-- don't move cursor when switching buffers
set.startofline = false

-- wrapping options http://vimdoc.sourceforge.net/htmldoc/change.html#fo-table
set.formatoptions=tcroqnb

set.directory = "/Users/dialtone/.vim/_temp"
set.wildignore:append("*.pyc")

vim.cmd([[
function WriteCreatingDirs()
    execute ':silent !mkdir -p %:h'
    write
endfunction
command W call WriteCreatingDirs()
]])

if vim.fn.has('gui_running') then
    set.guifont = { "FiraCode Nerd Font Mono", "h13" }
end

