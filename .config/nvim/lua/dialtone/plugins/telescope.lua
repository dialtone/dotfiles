local m = require("dialtone.utils")
local actions = require("telescope.actions")

require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    vimgrep_arguments = {
        "rg",
        "--follow",
        "--hidden",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--trim" -- add this value
    },
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key",
        -- close
        ["<esc>"] = actions.close,
        -- clear prompt
        ["<C-u>"] = false

      }
    }
  },
  pickers = {
    find_files = {
      find_command = {"fd", "--type", "f", "--hidden", "--follow", "--exclude", ".git" }
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  },
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')

-- Using Lua functions
m.nmap("<leader>p", "<cmd>lua require('telescope.builtin').find_files()<cr>")
m.nmap("<leader>g", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
m.nmap("<leader>;", "<cmd>lua require('telescope.builtin').buffers()<cr>")
m.nmap("<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>")
m.nmap("<Leader>fb", "<cmd>lua require('telescope.builtin').builtin()<cr>")
