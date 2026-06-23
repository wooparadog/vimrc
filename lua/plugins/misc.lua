return {
  -- File search / buffer management
  {
    "ctrlpvim/ctrlp.vim",
    cmd = { "CtrlP", "CtrlPBuffer", "CtrlPMRU", "CtrlPMixed" },
    keys = { { "<C-p>", "<cmd>CtrlP<CR>", desc = "[File] CtrlP find" } },
    init = function()
      vim.g.ctrlp_custom_ignore = [[\v[\/]\.(git|hg|svn|.venv)$]]
      vim.g.ctrlp_working_path_mode = "ra"
      vim.g.ctrlp_user_command = { ".git", "cd %s && git ls-files -co --exclude-standard" }
    end,
  },

  { "jlanzarotta/bufexplorer", cmd = { "BufExplorer", "ToggleBufExplorer", "BufExplorerHorizontalSplit", "BufExplorerVerticalSplit" } },

  -- Templates
  {
    "aperezdc/vim-template",
    event = "BufNewFile",
    init = function()
      vim.g.email = "guohaochuan@gmail.com"
      vim.g.username = "WooParadog"
      vim.g.templates_directory = { "~/.vim/templates/" }
    end,
  },

  -- Python virtualenv
  { "jmcantrell/vim-virtualenv", event = "VeryLazy" },

  -- Tags
  {
    "majutsushi/tagbar",
    cmd = { "TagbarToggle", "TagbarOpen", "Tagbar" },
    keys = { { "<F6>", "<cmd>TagbarToggle<CR>", desc = "[Tags] Toggle tagbar" } },
  },

  -- Emmet
  {
    "mattn/emmet-vim",
    event = "InsertEnter",
    init = function()
      vim.g.user_emmet_expandabbr_key = "<c-e>"
    end,
  },

  -- Ack
  {
    "mileszs/ack.vim",
    cmd = { "Ack", "AckAdd", "AckFromSearch", "AckWindow" },
    init = function()
      vim.g.ackprg = "ag --nogroup --nocolor --column"
    end,
  },

  -- MRU
  {
    "vim-scripts/mru.vim",
    -- Load early (not just on :MRU) so the BufRead/BufWritePost autocmds that
    -- track opened files are registered; cmd-only lazy loading meant the list
    -- never updated until :MRU was run manually.
    event = "VeryLazy",
    cmd = "MRU",
    init = function()
      vim.g.MRU_Max_Entries = 100
    end,
  },

  -- Eunuch (UNIX shell commands)
  {
    "tpope/vim-eunuch",
    cmd = { "Remove", "Delete", "Move", "Rename", "Chmod", "Mkdir", "Cfind", "Clocate", "Lfind", "Llocate", "Wall", "SudoEdit", "SudoWrite" },
  },

  -- Window resizer
  { "simeji/winresizer", cmd = "WinResizerStartResize" },

  -- Undo tree
  {
    "simnalamburt/vim-mundo",
    cmd = { "MundoToggle", "MundoShow", "MundoHide" },
    keys = { { "<F5>", "<cmd>MundoToggle<CR>", desc = "[Undo] Toggle undo tree" } },
    init = function()
      vim.g.mundo_prefer_python3 = 1
    end,
  },

  -- Rails / language extras
  { "tpope/vim-rails",       ft = { "ruby", "eruby" } },
  { "lepture/vim-jinja",     ft = { "jinja", "html.jinja" } },
  { "vim-python/python-syntax", ft = "python" },
  { "othree/xml.vim",        ft = { "xml", "html" } },
}
