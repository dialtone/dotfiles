-- https://github.com/nanotee/nvim-lua-guide
-- https://github.com/arnvald/viml-to-lua
-- https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/
-- https://github.com/VonHeikemen/dotfiles/tree/master/my-configs/neovim
-- https://gist.github.com/mbrc12/5e1bff33764626c26311956672bd0e77


if vim.g.neovide then
  vim.g.neovide_cursor_trail_length = 0
  vim.g.neovide_cursor_animation_length = 0
  -- use cmd key on mac
  vim.g.neovide_input_use_logo = true
  -- map alt to M- for keymaps
  vim.g.neovide_input_macos_alt_is_meta= true
end


require("dialtone.settings")
require("dialtone.plugins.install")
require("dialtone.plugins.setup")
require("dialtone.plugins.lualine")
require("dialtone.plugins.treesitter")
require("dialtone.plugins.telescope")
require("dialtone.plugins.dap")
require("dialtone.plugins.autopairs")
require("dialtone.plugins.gitsigns")

-- require("plugins.airline")
-- require("plugins.fzf")
-- require("plugins.fzf-lua")

require("dialtone.mappings")
require("dialtone.auto")


