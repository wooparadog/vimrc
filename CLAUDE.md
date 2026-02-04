# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration repository using a hybrid Vim script and Lua setup. The configuration uses vim-plug for plugin management and includes LSP integration, AI-assisted coding (Avante.nvim with Claude), and extensive language support.

This repo is a submodule of the primary dotfiles on $HOME. So you can treat current folder as a git repo.

## Common Commands

```vim
:PlugInstall          " Install plugins
:PlugUpdate           " Update plugins
:PlugClean            " Remove unused plugins
:Neoformat            " Format current file (also F12)
```

## Architecture

### Configuration Loading Chain

```
vimrc (entry point)
├── plugins.vim         → Plugin declarations (vim-plug)
└── lua/init.lua        → Lua module loader
    ├── settings.lua    → Editor settings (tabs, encoding, undo)
    └── plugins.lua     → LSP servers, completion, AI setup
        ├── complete.lua    → nvim-cmp configuration
        ├── statusline.lua  → Feline status bar
        ├── treesitter.lua  → Syntax highlighting
        ├── saga.lua        → LSP UI (lspsaga)
        ├── diff.lua        → Diffview.nvim
        └── browser.lua     → Nvim-tree
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

Avante.nvim is configured with OpenRouter API using Claude 3.7 Sonnet. Configuration is in `lua/plugins.lua` under the avante setup section.
