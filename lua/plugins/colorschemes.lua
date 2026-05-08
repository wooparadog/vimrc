-- Bundled colorschemes are kept lazy; the active theme is set in vimrc
-- (`colorscheme evening`, a built-in). To switch, run :colorscheme <name>
-- and lazy will load the relevant plugin.
return {
  { "flazz/vim-colorschemes",      lazy = true },
  { "dracula/vim",                 name = "dracula", lazy = true },
  { "AlessandroYorba/Sierra",      lazy = true },
  { "joshdick/onedark.vim",        lazy = true },
}
