local m = require("dialtone.utils")
-- all setup data is available here: https://github.com/ibhagwan/fzf-lua

m.nmap(';', "<cmd>lua require('fzf-lua').buffers()<cr>")
m.nmap('<leader>p', "<cmd>lua require('fzf-lua').files()<cr>")
m.nmap('<leader>l', "<cmd>lua require('fzf-lua').lines()<cr>")
m.nmap('<leader>g', "<cmd>lua require('fzf-lua').live_grep()<cr>")

local actions = require "fzf-lua.actions"
require'fzf-lua'.setup {
}
