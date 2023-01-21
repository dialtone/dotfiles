-- Configure LSP
-- https://github.com/neovim/nvim-lspconfig#rust_analyzer

local m = require('dialtone.utils')

vim.opt.completeopt = { 'menuone', 'noinsert', 'noselect' }
vim.opt.shortmess:append("c")

-- lspconfig object
local lspconfig = require'lspconfig'


-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
m.nmap('<leader>e', vim.diagnostic.open_float)
m.nmap('[d', vim.diagnostic.goto_prev)
m.nmap(']d', vim.diagnostic.goto_next)
m.nmap('<leader>q', vim.diagnostic.setloclist)

local rt = require("rust-tools")

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
  m.nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  m.nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  m.nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  m.nmap('<leader>D', vim.lsp.buf.type_definition, bufopts)
  m.nmap('<leader>rn', vim.lsp.buf.rename, bufopts)
  -- m.nmap('<leader>ca', vim.lsp.buf.code_action, bufopts)
  m.nmap('gr', vim.lsp.buf.references, bufopts)
  m.nmap('<leader>f', vim.lsp.buf.format, bufopts)
  -- Hover actions
  m.nmap("<leader>ha", rt.hover_actions.hover_actions, { buffer = bufnr })
  -- Code action groups
  m.nmap("<Leader>ca", rt.code_action_group.code_action_group, { buffer = bufnr })
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
        -- how to execute terminal commands
        -- options right now: termopen / quickfix
        executor = require("rust-tools/executors").termopen,

        -- callback to execute once rust-analyzer is done initializing the workspace
        -- The callback receives one parameter indicating the `health` of the server: "ok" | "warning" | "error"
        on_initialized = nil,

        -- These apply to the default RustSetInlayHints command
        inlay_hints = {
          -- automatically set inlay hints (type hints)
          -- default: true
          auto = true,

          -- Only show inlay hints for the current line
          only_current_line = false,

          -- whether to show parameter hints with the inlay hints or not
          -- default: true
          show_parameter_hints = true,

          -- prefix for parameter hints
          -- default: "<-"
          parameter_hints_prefix = "<- ",

          -- prefix for all the other hints (type, chaining)
          -- default: "=>"
          other_hints_prefix = "=> ",

          -- whether to align to the lenght of the longest line in the file
          max_len_align = false,

          -- padding from the left if max_len_align is true
          max_len_align_padding = 1,

          -- whether to align to the extreme right or not
          right_align = false,

          -- padding from the right if right_align is true
          right_align_padding = 7,

          -- The color of the hints
          highlight = "Comment",
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
    capabilities = require('cmp_nvim_lsp').default_capabilities(), --update_capabilities(vim.lsp.protocol.make_client_capabilities()),
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


-- local rt = require("rust-tools")
rt.setup(opts)
m.nmap("<Leader>rr", "<Cmd>RustRunnables<CR>")
m.nmap("<Leader>rd", "<Cmd>RustDebuggables<CR>")
m.nmap("<Leader>h", "<Cmd>RustOpenExternalDocs<CR>")


require('fidget').setup({})
require("nvim-surround").setup({})

-- Setup Completion
-- See https://github.com/hrsh7th/nvim-cmp#basic-configuration
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
local cmp = require'cmp'
local luasnip = require("luasnip")
-- this setup call fixes https://github.com/L3MON4D3/LuaSnip/issues/525
-- which allows the engine to remove untouched autocomplete markers when
-- the sequence of events happens
luasnip.config.setup({
    region_check_events = "CursorHold,InsertLeave,InsertEnter",
    delete_check_events = "TextChanged,InsertLeave",
})
cmp.setup({
  enabled = function()
    -- disable completion in comments
    local context = require 'cmp.config.context'
    -- keep command mode completion enabled when cursor is in a comment
    if vim.api.nvim_get_mode().mode == 'c' then
      return true
    else
      return not context.in_treesitter_capture("comment")
        and not context.in_syntax_group("Comment")
    end
  end,
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
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-s>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = false,
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },

  -- Installed sources
  sources = {
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
    { name = "crates" },
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

require("luasnip.loaders.from_vscode").load()
require("luasnip.loaders.from_vscode").load({ paths = {'~/.config/nvim/my-snippets'} })

