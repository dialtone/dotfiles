local M = {}

function M.map(mode, lhs, rhs, opts)
  local options = {noremap = true, silent = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.keymap.set(mode, lhs, rhs, options)
end

function M.nmap(shortcut, command, opts)
  M.map('n', shortcut, command, opts)
end

function M.imap(shortcut, command, opts)
  M.map('i', shortcut, command, opts)
end

function M.vmap(shortcut, command, opts)
  M.map('v', shortcut, command, opts)
end

function M.cmap(shortcut, command, opts)
  M.map('c', shortcut, command, opts)
end

function M.tmap(shortcut, command, opts)
  M.map('t', shortcut, command, opts)
end

return M
