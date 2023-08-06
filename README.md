# NeovimConfig

my neovim configuration

## How to use

### Install

download [Packer.nvim](https://github.com/wbthomason/packer.nvim)

clone this repo

add

    require(.....Entry.lua)

to your init.lua

download [font](https://www.nerdfonts.com/font-downloads)

for [instance](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.0/SpaceMono.zip)

    :PackerSync

### UpdatePlugin

    :PackerSync

    :MasonUpdate

## If You Want to Get Better Lsp Experience

- generate compile\_commands.json
- switch you toolchain to clang (or llvm?),
because we have clangd as cpp server

for instance

    xmake project -k compile_commands
    xmake f --toolchain=clang

## Plugin List:

- Packer.nvim: plugin manager
- alpha-nvim: ui
- tokyonight: theme
- indent-blankline
- gitsigns.nvim: show diff while editing
- nvim-lspconfig
- & mason ... (:Mason)
- & cmp ... : lsp & auto completion
- nvim-web-devicons: to show icons, used by other plugins
- nvim-lualine: state bar
- nvim-treesitter: highlight
- nvim-tree: file explorer

