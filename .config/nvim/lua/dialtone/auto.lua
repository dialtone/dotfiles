local au = vim.api.nvim_create_autocmd
local ag = vim.api.nvim_create_augroup

local gen = ag('general', { clear = true })

local function setup_markdown()
    local set = vim.bo

    set.wrapmargin=2
    set.textwidth=120
    set.tabstop=2
    set.shiftwidth=2
    set.filetype="markdown"
end

au({"BufRead", "BufNewFile"}, {
    pattern="*.{md,markdown,mdown,mkd,mkdn}",
    callback=setup_markdown,
    group=gen,
})

-- Highlight yanked area for 500ms
-- au TextYankPost * silent! lua vim.highlight.on_yank()
au("TextYankPost", {pattern="*", group=gen, callback=function()
    vim.highlight.on_yank({timeout=500})
end
})


-- Remember last location in file, but not for commit messages.
-- see :help last-position-jump
vim.cmd([[
augroup reloader
    au!
    au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END
]])

-- set of files for which we'll spell check
vim.cmd([[
augroup spellcheck_documentation
  au!
  autocmd BufNewFile,BufRead *.md setlocal spell
  autocmd BufNewFile,BufRead *.rdoc setlocal spell
augroup END
]])


-- function keeps the cursor where it should be even if somehow this formatting calls moves it
local function format_rust()
    local lineno = vim.api.nvim_win_get_cursor(0)
    vim.lsp.buf.formatting_sync(nil, 1000)
    vim.api.nvim_win_set_cursor(0, lineno)
end
au("BufWritePre", {pattern="*.rs", group=gen, callback=format_rust})


au("FileType", {pattern="make", group=gen, callback=function ()
    vim.bo.expandtab=true
end
})


-- autoformat go with organization of imports
au("BufWritePre", {
  pattern = { "*.go" },
  group = gen,
  callback = function()
    vim.lsp.buf.formatting_sync(nil, 3000)
  end,
})

-- use q to leave buffer
au('FileType', {
  group = gen,
  pattern = {'qf', 'help', 'man', 'lspinfo', 'harpoon', 'null-ls-info'},
  command = 'nnoremap <buffer> q <cmd>quit<cr>'
})

-- organize imports
au("BufWritePre", {
    pattern = { "*.go" },
    group = gen,
    callback = function()
        local params = vim.lsp.util.make_range_params(nil, vim.lsp.util._get_offset_encoding())
        params.context = {only = {"source.organizeImports"}}

        local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
        for _, res in pairs(result or {}) do
            for _, r in pairs(res.result or {}) do
                if r.edit then
                    vim.lsp.util.apply_workspace_edit(r.edit, vim.lsp.util._get_offset_encoding())
                else
                    vim.lsp.buf.execute_command(r.command)
                end
            end
        end
    end,
})

