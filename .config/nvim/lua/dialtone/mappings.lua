local m = require('dialtone.utils')

-- vim.g.mapleader = ','

-- double percentage sign in command mode is expanded
-- to directory of current file - http://vimcasts.org/e/14
m.cmap("%%", "<C-R>=expand('%:h').'/'<cr>")

-- back to previous buffer
m.nmap("<leader><leader>", "<C-^>")

-- vim.cmd[[
--     map <m-d-left> :bp<cr>
--     map <m-d-right> :bn<cr>
-- ]]
-- Change buffer in the current split
-- vim.api.nvim_set_keymap("", "<C-Left>", ":bprevious<CR>", {noremap=false, silent=false})
-- vim.api.nvim_set_keymap("", "<C-Right>", ":bnext<CR>", {noremap=false, silent=false})

-- vim.api.nvim_set_keymap("n", "<Left>", ":bp<CR>", {noremap=false})
-- vim.api.nvim_set_keymap("n", "<Right>", ":bn<CR>", {noremap=false})
m.nmap("<Left>", ":bp<CR>", {noremap=false})
m.nmap("<Right>", ":bn<CR>", {noremap=false})

-- stay in indent mode
m.vmap("<", "<gv")
m.vmap(">", ">gv")

-- Move text up and down
m.vmap("<C-j>", ":m .+1<CR>==")
m.vmap("<C-k>", ":m .-2<CR>==")
-- keep the yank register when highlight/paste to replace
m.vmap("p", '"_dP')

-- Allow clipboard copy paste in neovim
m.map("", "<D-v>", '"+p')
m.map("!", "<D-v>", "<C-R>+")
m.tmap("<D-v>", "<C-R>+")
m.vmap("<D-c>", '"+y')

-- Visual Block --
-- Move text up and down
m.vmap("J", ":move '>+1<CR>gv-gv")
m.vmap("K", ":move '<-2<CR>gv-gv")
m.vmap("<C-j>", ":move '>+1<CR>gv-gv")
m.vmap("<C-k>", ":move '<-2<CR>gv-gv")

-- Map Escape
m.imap("<c-L>", "<Esc>")

-- Remap convenient vertical/horizontal split
m.map("", "<leader>s", ":split<CR>")
m.map("", "<leader>v", ":vsplit<CR>")
m.map("", "<leader>u", "<C-w>q")
m.map("", "<leader>U", "<C-w><C-o>")

-- Remap auto-pairs
-- map("", "<leader>k", "<m-p>")
-- map("", "<leader>n", "<m-n>")

-- Remap window close but don't delete buffer
m.map("", "``", ":q<cr>")
m.map("", "<leader>``", ":q!<cr>")

-- Remap buffer delete
m.map("", "<leader>bd", ":bd<cr>")
m.map("", "<leader>BD", ":bd!<cr>")

-- Remap moving between splits
m.nmap("<c-j>", "<c-w>j")
m.nmap("<c-k>", "<c-w>k")
m.nmap("<c-h>", "<c-w>h")
m.nmap("<c-l>", "<c-w>l")

-- force close the quickfix window
m.nmap("cq", ":cclose<cr>")


-- when in terminal mode, leave terminal mode with simple ESC key
m.tmap("<Esc>", "<C-\\><C-n>")

-- don't use Ex mode, use Q for formatting
m.map("", "Q", "gq")

-- clear search buffer when hitting return
m.nmap("<CR>", ":nohlsearch<cr>")

-- w!! if you forget to sudo before saving
m.cmap("w!!", "w !sudo tee % >/dev/null")

-- bernie: search for highlighted text
--:vmap // y/<C-R>"<CR>


-- Movement in insert mode
-- single movements h j k l
m.map("!", "<Leader>h", "<left>")
m.map("!", "<Leader>j", "<down>")
m.map("!", "<Leader>k", "<up>")
m.map("!", "<Leader>l", "<right>")
-- append shortcuts
m.map("!", "<Leader>A", "<esc>A")
m.map("!", "<Leader>a", "<esc>a")
-- new line and insert shortcuts
m.map("!", "<Leader>O", "<esc>O")
m.map("!", "<Leader>o", "<esc>o")

-- reload config
function _G.reload_nvim_conf()
  for name,_ in pairs(package.loaded) do
    if name:match('^dialtone') then -- or name:match('^lsp') or name:match('^plugins') thenreload
      package.loaded[name] = nil
    end
  end

  dofile(vim.env.MYVIMRC)
  vim.notify("Nvim configuration reloaded!", vim.log.levels.INFO)
end
m.nmap("<Leader>%%", "<cmd>lua reload_nvim_conf()<CR>")


m.nmap("<leader>o", ":PyrightOrganizeImports<cr>")

-- Highlight all instances of word under cursor, when idle.
-- Useful when studying strange source code.
-- Type z/ to toggle highlighting on/off.
m.nmap("z/", ":if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>")
vim.cmd([[
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
]])

