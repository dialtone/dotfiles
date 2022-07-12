-- Configure LSP
-- https://github.com/neovim/nvim-lspconfig#rust_analyzer

local m = require('dialtone.utils')

vim.opt.completeopt = { 'menuone', 'noinsert', 'noselect' }
vim.opt.shortmess:append("c")

-- lspconfig object
local lspconfig = require'lspconfig'


-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
m.nmap('<space>e', vim.diagnostic.open_float)
m.nmap('[d', vim.diagnostic.goto_prev)
m.nmap(']d', vim.diagnostic.goto_next)
m.nmap('<space>q', vim.diagnostic.setloclist)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  -- local bufopts = { noremap=true, silent=true, buffer=bufnr }
  local bufopts = { buffer=bufnr }
  m.nmap('gD', vim.lsp.buf.declaration, bufopts)
  m.nmap('gd', vim.lsp.buf.definition, bufopts)
  m.nmap('K', vim.lsp.buf.hover, bufopts)
  m.nmap('gi', vim.lsp.buf.implementation, bufopts)
  m.nmap('<C-k>', vim.lsp.buf.signature_help, bufopts)
  m.nmap('<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  m.nmap('<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  m.nmap('<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  m.nmap('<space>D', vim.lsp.buf.type_definition, bufopts)
  m.nmap('<space>rn', vim.lsp.buf.rename, bufopts)
  m.nmap('<space>ca', vim.lsp.buf.code_action, bufopts)
  m.nmap('gr', vim.lsp.buf.references, bufopts)
  m.nmap('<space>f', vim.lsp.buf.formatting, bufopts)
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


-- -- code navigation shortcuts
-- m.nmap("ga", "<cmd>lua vim.lsp.buf.code_action()<CR>")
-- m.nmap("gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
-- m.nmap("K", "<cmd>lua vim.lsp.buf.hover()<CR>")
-- m.nmap("<c+k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
-- m.nmap("gD", "<cmd>lua vim.lsp.buf.implementation()<CR>")
-- m.nmap("gT", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
-- m.nmap("rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
-- m.nmap("gr", "<cmd>lua vim.lsp.buf.references()<CR>")
-- m.nmap("g0", "<cmd>lua vim.lsp.buf.document_symbol()<CR>")
-- m.nmap("gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>")
--
-- m.nmap("g[", ":lua vim.diagnostic.goto_prev()<CR>")
-- m.nmap("g]", ":lua vim.diagnostic.goto_next()<CR>")

-- debug codelens stuff
m.nmap("<leader>cf", "<Cmd>lua vim.lsp.codelens.refresh()<CR>")
m.nmap("<leader>cr",  "<Cmd>lua vim.lsp.codelens.run()<CR>")

-- visualize diagnostics
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

vim.api.nvim_set_option('updatetime', 1000)
local aug = vim.api.nvim_create_augroup('plug_setup', { clear = true })
vim.api.nvim_create_autocmd("CursorHold", {pattern="*", group=aug, callback=function()
    vim.diagnostic.open_float()
end})

-- vim.cmd([[
-- function! LspStatus() abort
--     let sl = ''
--     if luaeval('not vim.tbl_isempty(vim.lsp.buf_get_clients(0))')
--         let sl.='%#MyStatuslineLSP#E:'
--         let sl.='%#MyStatuslineLSPErrors#%{luaeval("vim.lsp.util.buf_diagnostics_count([Error])")}'
--         let sl.='%#MyStatuslineLSP# W:'
--         let sl.='%#MyStatuslineLSPWarnings#%{luaeval("vim.lsp.util.buf_diagnostics_count([Warning])")}'
--     else
--         let sl.='%#MyStatuslineLSPErrors#off'
--     endif
--     return sl
-- endfunction
-- let &l:statusline = '%#MyStatuslineLSP#LSP '.LspStatus()
-- ]])


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

-- lspconfig.jsonls.setup{}
-- lspconfig.terraformls.setup{}
-- lspconfig.html.setup{}
-- lspconfig.clangd.setup{}
-- need to install taplo-cli: cargo install taplo-cli --features lsp
lspconfig.taplo.setup{}
lspconfig.pyright.setup{}

-- local runtime_path = vim.split(package.path, ';')
-- table.insert(runtime_path, "lua/?.lua")
-- table.insert(runtime_path, "lua/?/init.lua")
lspconfig.sumneko_lua.setup{
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
                pathStrict = false,
                -- path = runtime_path,
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = {'vim'},
            },
            workspace = {
                -- Make the server aware of Neovim files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            }
        }
    }
}

local extension_path = '/Users/dialtone/.vscode/extensions/vadimcn.vscode-lldb-1.7.0/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.dylib'

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
            max_len_align = false,
            max_len_align_padding = 1,
            right_align = false,
            right_align_padding = 7,
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
    on_attach=on_attach,
    flags = {
        debounce_text_changes = 150,
    },
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    settings = {
      ["rust-analyzer"] = {
          assist = {
              importGranularity = "module",
              importPrefix = "self",
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
          lens = {
              enable = true,
              debug = {
                  enable = true,
              }
          },
          updates = {
              channel = "nightly",
          },
      },
    },
  }, -- rust-analyer options

  dap = {
    adapter = require('rust-tools.dap').get_codelldb_adapter(
            codelldb_path, liblldb_path)
  },
}

require('rust-tools').setup(opts)
m.nmap("<Leader>rr", "<Cmd>RustRunnables<CR>")
m.nmap("<Leader>rd", "<Cmd>RustDebuggables<CR>")


require('fidget').setup({})

-- Setup Completion
-- See https://github.com/hrsh7th/nvim-cmp#basic-configuration
local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
      require'luasnip'.lsp_expand(args.body)
    end
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
    { name = 'buffer' },
    { name = 'luasnip' },
    { name = 'path' },
  },
})

cmp.setup.filetype('markdown', {
  enabled=false,
})

vim.g.vim_markdown_new_list_item_indent = 2
vim.g.markdown_fenced_languages = {'html', 'vim', 'ruby', 'python', 'bash=sh', 'rust', 'go'}
vim.g.root_pattern = {'.git/'}


-- autopairs
-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

