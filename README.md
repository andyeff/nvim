# nvim

! DEPRECATED OLD BRANCH - main should now be up to date with a more 100% lua config !

WIP nvim config

Clone into ~/.config

Will create the nvim directory

## Prerequisites

I advise using homebrew. It is good.

I have a weird-ass way of maintaining python, but you might want to include it in a brew install below if you aren't a wacky one.

`brew install nvim pyright rust-analyzer gopls`

First invoke of nvim will probably throw some warnings. Ignore those, and run `:PlugInstall`

For tree-sitter, install your favourite language defs with `:TSInstall <language>`  
A list of supported languages can be found on [Github](https://github.com/nvim-treesitter/nvim-treesitter#supported-languages)
