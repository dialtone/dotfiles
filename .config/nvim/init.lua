-- https://github.com/nanotee/nvim-lua-guide
-- https://github.com/arnvald/viml-to-lua
-- https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/
-- https://github.com/VonHeikemen/dotfiles/tree/master/my-configs/neovim
-- https://gist.github.com/mbrc12/5e1bff33764626c26311956672bd0e77
--
require("plugins.install")
require("plugins.setup")
-- require("plugins.airline")
require("plugins.lualine")
require("plugins.treesitter")
-- require("plugins.fzf")
require("plugins.fzf-lua")
require("plugins.dap")
require("settings")
require("mappings")
require("auto")

