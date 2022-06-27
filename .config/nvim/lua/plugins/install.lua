return require('packer').startup(function() 
    use 'wbthomason/packer.nvim'

    use 'neovim/nvim-lspconfig'
    use 'tjdevries/lsp_extensions.nvim'

    use 'hrsh7th/nvim-cmp'

    -- LSP completion source for nvim-cmp
    use 'hrsh7th/cmp-nvim-lsp'

    -- Snippet completion source for nvim-cmp
    use { 'L3MON4D3/LuaSnip' }
    use { 'saadparwaiz1/cmp_luasnip' }
    -- use 'hrsh7th/cmp-vsnip'
    -- use 'hrsh7th/vim-vsnip'

    -- Other useful completion sources
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-buffer'

    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }  -- We recommend updating the parsers on update
    use 'nvim-treesitter/nvim-treesitter-textobjects'

    -- Debugger DAP protocol integration
    use 'mfussenegger/nvim-dap'

    use 'lifepillar/vim-gruvbox8'

    use 'nvim-lua/plenary.nvim'
    use 'simrat39/rust-tools.nvim'

    -- Optional dependencies
    -- use 'nvim-lua/popup.nvim'
    -- use 'nvim-telescope/telescope.nvim'

    -- nvim 0.4+
    use 'junegunn/vim-easy-align'
    use 'airblade/vim-rooter'

    use { 'ibhagwan/fzf-lua',
      -- optional for icon support
      requires = { 'kyazdani42/nvim-web-devicons' }
    }

    -- use 'junegunn/fzf'
    -- use 'junegunn/fzf.vim'

    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }

    -- Populate scroll bar with dots where diagnostics is
    -- use {
    --   'lewis6991/satellite.nvim',
    --   config = function()
    --     require('satellite').setup()
    --   end
    -- }

    -- use 'scrooloose/nerdtree'
    -- use 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
    -- use 'vim-airline/vim-airline'
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

    use 'tpope/vim-commentary'

    use 'cespare/vim-toml'
    -- Initialize plugin system
end)
