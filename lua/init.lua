-- Set leader keys before lazy loads so plugin keymaps register correctly
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.options")
require("config.lazy")
require("config.keymaps")
