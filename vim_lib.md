# VIM

## Script commands

### Map
* map <F7> :NERDTreeToogle<CR>
* imap : insert mode mapping
* nmap : normal mode
* noremap : no recursive mapping
* nnoremap : normal mode noremap
* See details with `:help :map-commands`

### Autocmd
//TODO

## Normal mode commands

### Search file by content
* `:vimgrep /import/ **` search all
* `:vimgrep /import/g **` search all. result inlcude a line for each match. And will jump to result.
* `:vimgrep /import/j **` search all. Silent search. Use clist to check.
* `:vimgrep /import/ *.md` 
* `:vimgrep /import/ **/*.md`
* `:clist`
* `:cnext`
* `:cprevious`

### Set vs Let
* Set is used to set system-defined fields (vim refers it as **option**)
* Let is used to set custom fields
* System-defined fields (aka options) types:
    * Toggle option (aka boolean field)
    * Number option (aka int field)
    * String option (aka string field)
* :set all - show all set options
* :set number - turn on boolean field
* :set number? - query field
* :set number! - toogle boolean field
* :set tabwidth=4 - set non boolean field
* :help set

### Navigation
Commands below can be run under normal mode. Most of them has counter-part
* { : beginning of paragraph
* ( : beginning of sentence
* `[[` : last definition
* gd : go to definition of field/function
* gf : go to dependency file (doesn't really work well...)

### Help
* Ask for help with `:help *topic*`

### Normal mode grammer
* [Times][Actions][Where]
* [Times] is a number
* [Actions]: d, y, p, g and etc
* [Where]: w, b, e, {, ) and etc
* For example: 3de

## Built-in package/plugin management
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
