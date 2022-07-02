local m = require('dialtone.utils')

vim.opt.rtp:append("/opt/homebrew/bin/fzf")

m.nmap(";", ":Buffers<CR>")
m.nmap("<Leader>p", ":Files<CR>")
m.nmap("<Leader>l", ":Lines<CR>")
m.nmap("<Leader>g", ":Rg<CR>")

vim.cmd([[
let g:fzf_layout = { 'down': '~20%' }

command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
            \   <bang>0 ? fzf#vim#with_preview('up:60%')
            \           : fzf#vim#with_preview('right:50%:hidden', '?'),
            \   <bang>0)
]])
