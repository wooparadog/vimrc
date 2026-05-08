-- Global keymaps. Plugin-specific keymaps live next to their plugin spec
-- under lua/plugins/, but ones that target plugins via <cmd>X<CR> remain
-- here so the layout stays discoverable. The :Keymaps viewer reads these
-- via vim.api.nvim_get_keymap.

local map = vim.keymap.set

-- Window Navigation
map("n", "<C-h>", "<C-W>h", { desc = "[Window] Move to left window" })
map("n", "<C-j>", "<C-W>j", { desc = "[Window] Move to bottom window" })
map("n", "<C-k>", "<C-W>k", { desc = "[Window] Move to top window" })
map("n", "<C-l>", "<C-W>l", { desc = "[Window] Move to right window" })

-- Text Manipulation
map("n", "<leader>z", [[:%s#\<<C-r>=expand("<cword>")<CR>\>#]], { desc = "[Text] Substitute word under cursor" })
map("v", "<C-r>", [["hy:%s#<C-r>h##gc<left><left><left>]], { desc = "[Text] Substitute visual selection" })
map("v", "<leader>y", '"+y', { desc = "[Text] Copy to system clipboard" })

-- Search (functions defined in vimrc)
map("v", "*", ":call VisualSearch('f')<CR>", { silent = true, desc = "[Search] Search selection forward" })
map("v", "#", ":call VisualSearch('b')<CR>", { silent = true, desc = "[Search] Search selection backward" })
map("v", "gv", ":call VisualSearch('gv')<CR>", { silent = true, desc = "[Search] Grep visual selection" })

-- Git (GitGrepWord defined in vimrc; Ack provided by ack.vim)
map("n", "<C-x><C-x>", ":call GitGrepWord()<CR>", { desc = "[Git] Grep word under cursor" })
map("n", "<C-x><C-g>", ":Ack<CR>", { desc = "[Git] Open Ack search" })

-- File (RunSrc defined in vimrc; Neoformat provided by sbdchd/neoformat)
map("n", "<F11>", ":call RunSrc()<CR>", { desc = "[File] Run current file" })
map("n", "<F12>", ":Neoformat<CR>", { desc = "[File] Format with Neoformat" })

-- LSP (built-in)
map("n", "gd", vim.lsp.buf.definition, { desc = "[LSP] Go to definition" })

-- Help
map("n", "<leader>h", "<cmd>Keymaps<CR>", { desc = "[Help] Show keymaps" })

-- Tmux
map("v", "<leader>t", ":<C-u>'<,'>w !tmux load-buffer -<CR>", { desc = "[Tmux] Send selection to tmux buffer" })

-- Terminal toggle (function defined in vim plugin)
map("n", "<F7>", ":call terminal#toggle()<CR>", { desc = "[Terminal] Toggle terminal" })
map("t", "<F7>", [[<C-\><C-n>:call terminal#toggle()<CR>]], { desc = "[Terminal] Toggle terminal" })

-- Register the :Keymaps user command
require("util.keymaps_viewer")
