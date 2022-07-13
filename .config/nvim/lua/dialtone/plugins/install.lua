return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use 'neovim/nvim-lspconfig'
    use 'tjdevries/lsp_extensions.nvim'

    use 'hrsh7th/nvim-cmp'

    -- LSP completion source for nvim-cmp
    use 'hrsh7th/cmp-nvim-lsp'

    -- Snippet completion source for nvim-cmp
    use { 'L3MON4D3/LuaSnip' }
    use { 'saadparwaiz1/cmp_luasnip' }

    -- Other useful completion sources
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-buffer'

    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }  -- We recommend updating the parsers on update
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'nvim-treesitter/playground'

    -- Debugger DAP protocol integration
    use 'mfussenegger/nvim-dap'
    use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
    use 'theHamsta/nvim-dap-virtual-text'

    use 'lifepillar/vim-gruvbox8'
    use "EdenEast/nightfox.nvim" -- Packer

    use 'nvim-lua/plenary.nvim'
    use 'simrat39/rust-tools.nvim'

    -- spinner for lsp in bottom right
    use 'j-hui/fidget.nvim'

    -- wrap insert parenthesis or other wrapping characters
    use "kylechui/nvim-surround"

    -- nvim 0.4+
    use 'junegunn/vim-easy-align'
    use 'airblade/vim-rooter'

    use {
      'nvim-telescope/telescope.nvim',
      requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use {'nvim-telescope/telescope-ui-select.nvim' }

    use "windwp/nvim-autopairs"

    -- Populate scroll bar with dots where diagnostics is
    -- use {
    --   'lewis6991/satellite.nvim',
    --   config = function()
    --     require('satellite').setup()
    --   end
    -- }

    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    use {
      'kdheepak/tabline.nvim',
      config = function()
        require'tabline'.setup {enable=true}
      end,
      requires = {'hoob3rt/lualine.nvim', 'kyazdani42/nvim-web-devicons'}
    }

    use 'dag/vim-fish'
    use 'godlygeek/tabular'
    use 'preservim/vim-markdown'

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    use {
      'lewis6991/gitsigns.nvim',
      -- tag = 'release' -- To use the latest release
    }

    -- Initialize plugin system
end)
