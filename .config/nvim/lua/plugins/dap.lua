local m = require("utils")

m.nmap("<F5>", "<Cmd>lua require'dap'.continue()<CR>")
m.nmap("<F10>", "<Cmd>lua require'dap'.step_over()<CR>")
m.nmap("<F11>", "<Cmd>lua require'dap'.step_into()<CR>")
m.nmap("<F12>", "<Cmd>lua require'dap'.step_out()<CR>")
m.nmap("<Leader>b", "<Cmd>lua require'dap'.toggle_breakpoint()<CR>")
m.nmap("<Leader>B", "<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
m.nmap("<Leader>lp", "<Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")
m.nmap("<Leader>dr", "<Cmd>lua require'dap'.repl.open()<CR>")
m.nmap("<Leader>dl", "<Cmd>lua require'dap'.run_last()<CR>")

