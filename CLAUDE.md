# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration repository using a hybrid Vim script and Lua setup. The configuration uses lazy.nvim for plugin management and includes LSP integration, Codeium completion, and extensive language support.

This repo is a submodule of the primary dotfiles on $HOME. So you can treat current folder as a git repo.

## Common Commands

```vim
:Lazy                 " Open the lazy.nvim UI
:Lazy sync            " Install missing + update existing plugins
:Lazy clean           " Remove unused plugins
:Lazy check           " Check for plugin updates
:Neoformat            " Format current file (also F12)
```

## Architecture

### Configuration Loading Chain

```
vimrc (entry point)
└── lua/init.lua            → Sets leader, then loads config modules
    ├── config/options.lua  → Editor options + autocmds
    ├── config/lazy.lua     → Bootstraps lazy.nvim, imports lua/plugins/
    │   └── lua/plugins/*   → One spec file per logical group
    │       ├── ui.lua          → devicons, feline, bufferline, colorizer, ...
    │       ├── colorschemes.lua
    │       ├── treesitter.lua
    │       ├── lsp.lua         → nvim-lspconfig + lspsaga
    │       ├── cmp.lua         → nvim-cmp + sources + vsnip keymaps
    │       ├── ai.lua          → Codeium
    │       ├── nvim-tree.lua
    │       ├── git.lua         → gitsigns, fugitive, gitgutter, diffview, ...
    │       ├── editing.lua     → surround, easy-align, neoformat, ALE, ...
    │       ├── markdown.lua
    │       └── misc.lua        → ctrlp, tagbar, mundo, ack, mru, emmet, ...
    └── config/keymaps.lua  → Global keymaps + :Keymaps viewer command
```

### Key Directories

- `lua/` - Modular Lua configuration
- `ftplugin/` - Language-specific settings (python, go, typescript, etc.)
- `plugin/` - Custom Vim plugins (ddldbl.vim for duplicate/blank line removal)
- `templates/` - File templates for vim-template plugin
- `autoload/` - vim-plug installation

## LSP Configuration

LSP servers are configured in `lua/plugins.lua`:
- **Python**: Pyright
- **Go**: Gopls
- **TypeScript**: ts_ls
- **C/C++**: Clangd
- **Lua**: lua_ls
- **Rust**: rust-analyzer
- **CSS**: Tailwind CSS

LSP file watcher is disabled for performance on Linux.

## Key Mappings Reference

| Key | Action |
|-----|--------|
| `<F2>` | Toggle NvimTree |
| `<F5>` | Toggle Mundo (undo tree) |
| `<F6>` | Toggle Tagbar |
| `<F7>` | Toggle terminal |
| `<F11>` | Run current file |
| `<F12>` | Neoformat |
| `<leader>1-9` | Switch to buffer tab |
| `K` | LSP hover |
| `<leader>r` | LSP rename |
| `<leader>f` | Code actions |
| `<leader>gd` | Peek definition |
| `[e` / `]e` | Previous/next diagnostic |

## Language-Specific Notes

- **Python** (`ftplugin/python.vim`): Uses black, isort, autoflake via ALE; colorcolumn at 79
- **Go** (`ftplugin/go.vim`): Uses goimports, golangci-lint; tabs not spaces
- **TypeScript** (`ftplugin/typescript.vim`): 2-space indent; eslint via ALE

## AI Integration

Codeium provides inline completion suggestions and chat. Configuration is in
`lua/plugins/ai.lua` and the source is wired into `nvim-cmp` via the
`codeium` source in `lua/plugins/cmp.lua`.
