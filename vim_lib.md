# VIM

## How to write a plugin and where to reference
* Reference to popular plugins
* Go to /usr/share/vim and find autoload, syntax, ftplugin (etc) system sample

## Make command and errorFormat
* Make command can be bound with different program like gcc, javac, gradle
* Reference to github project: vim-gradle
* ErrorFormat is used to parse the build command output and present to user at quickfix window
* `:compiler gradlew` and then `:make {gradle-task}`
* Famous plugins CtrlP takes advantage of the make system in vim and bind it with execute *find* and map output to errorFormat.

## Search for files 
* `:help find`
* Amazing when use with `:set wildmenu` 
* `:find *.md` and Tab

## Use python in vim
* :echo has("python")
* :python print("hello world")
* :pyfile mypython.py
* In python script, there is a vim module to be used:
    ```python
    import vim
    window = vim.current.window
    window.height =200
    window.width = 10
    window.cursor = (1,1)
    ```

## Register
* Its about clipboard history.

## Session
* Session is the working status you are having with the file. 
* `:mksession` to save 
* Similarly, `:mkview` to save view

## Tag
* To create tag list, we can use ctag (most popular), vtags etc.
* Let vim know where is the tag file and it will be able to navigate
* Plugin *tagbar* can present.

## Use abbrev to insert code snippet
* `iabbrev <buffer> for( for (x=0;x<var;x++){<cr><cr>}`

## Use Autocmd to insert template
* `autocmd BufNewFile *.html 0r $VIMHOME/templates/html.tpl`
* `autocmd BufNewFile * silent! 0r $VIMHOME/templates/%:e.tpl`

## Map
* map <F7> :NERDTreeToogle<CR>
* map <F7> dd
* imap : insert mode mapping
* nmap : normal mode
* noremap : no recursive mapping
* nnoremap : normal mode noremap
* See details with `:help :map-commands`

## Autocmd
//TODO

## Search file by content
* `:vimgrep /import/ **` search all
* `:vimgrep /import/g **` search all. result inlcude a line for each match. And will jump to result.
* `:vimgrep /import/j **` search all. Silent search. Use clist to check.
* `:vimgrep /import/ *.md` 
* `:vimgrep /import/ **/*.md`
* `:clist`
* `:cnext`
* `:cprevious`

## Set vs Let
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

## Normal mode commands

### Navigation
Commands below can be run under normal mode. Most of them has counter-part
* { : beginning of paragraph
* ( : beginning of sentence
* `[[` : last definition
* gd : go to definition of field/function
* gf : go to dependency file (doesn't really work well...)

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

## Help
* Ask for help with `:help *topic*`

## Pathogen - package manager
* Installation: 
    * download the pathogen.vim to ~/.vim/autoload/pathogen.vim
    * add to vimrc: execute pathogen#infect()
* Usage: download any plugin into ~/.vim/bundle/ and pathogen will auto-deploy the plugin, so no need to change config file# The plugin manager pathogen:

## Good resource
* [What I wish i knew](https://hackernoon.com/learning-vim-what-i-wish-i-knew-b5dca186bef7)
