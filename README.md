# nvim

Trying to make a better config ..

## Prerequisites

I advise using homebrew. It is good.

I have a weird-ass way of maintaining python, but you might want to include it in a brew install below if you aren't a wacky one.

`brew install nvim pyright rust-analyzer gopls`

Run this to install the packer pre-reqs:
```
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

First invoke of nvim will probably throw some warnings. Ignore those, and run `:PackerSync`

For tree-sitter, install your favourite language defs with `:TSInstall <language>`  
A list of supported languages can be found on [Github](https://github.com/nvim-treesitter/nvim-treesitter#supported-languages)

Mason is the LSP handler of choice, it will prompt to install things if you don't already have them, so you can pre-populate in the lsp.lua 

It *may* take 1-2 runs of launching nvim, running :PackerSync, and maybe some :TSInstall / :TSUpdate fun and games before it's happy.
