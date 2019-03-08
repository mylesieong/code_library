# VIM

## Build in package/plugin management
* Vim will check ~/.vim/pack/ after boots and load .vimrc
* All packages will be the added to `runtimepath`
* Use `:help packages` to get more info
* Packages are composed of plugins

## Pathogen - package manager
* Installation: 
    * download the pathogen.vim to ~/.vim/autoload/pathogen.vim
    * add to vimrc: execute pathogen#infect()
* Usage: download any plugin into ~/.vim/bundle/ and pathogen will auto-deploy the plugin, so no need to change config file# The plugin manager pathogen:


## Good resource
* [What I wish i knew](https://hackernoon.com/learning-vim-what-i-wish-i-knew-b5dca186bef7)
