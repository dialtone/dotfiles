local au = vim.api.nvim_create_autocmd
local ag = vim.api.nvim_create_augroup

function setup_markdown()
    local set = vim.bo

    set.wrapmargin=2
    set.textwidth=120
    set.tabstop=2
    set.shiftwidth=2
    set.filetype="markdown"
end

au({"BufRead", "BufNewFile"}, {
    pattern="*.{md,markdown,mdown,mkd,mkdn}", 
    callback=setup_markdown
})

-- Highlight yanked area for 500ms
-- au TextYankPost * silent! lua vim.highlight.on_yank()
au("TextYankPost", {pattern="*", callback=function()
    vim.highlight.on_yank({timeout=500})
end
})


-- Remember last location in file, but not for commit messages.
-- see :help last-position-jump
vim.cmd([[
au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
]])

-- set of files for which we'll spell check
vim.cmd([[
augroup spellcheck_documentation
  autocmd BufNewFile,BufRead *.md setlocal spell
  autocmd BufNewFile,BufRead *.rdoc setlocal spell
augroup END
]])


-- function keeps the cursor where it should be even if somehow this formatting calls moves it
function format_rust()
    local lineno = vim.api.nvim_win_get_cursor(0)
    vim.lsp.buf.formatting_sync(nil, 1000)
    vim.api.nvim_win_set_cursor(0, lineno)
end
au("BufWritePre", {pattern="*.rs", callback=format_rust})


au("FileType", {pattern="make", callback=function ()
    vim.bo.expandtab=true
end
})


-- autoformat go
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
au("BufWritePre", {pattern="*.go", callback=function()
    go_organize_import_sync(1000)
end})
au("BufWritePre", {pattern="*.go", callback=vim.lsp.buf.formatting})
