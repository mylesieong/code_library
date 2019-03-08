# Bash

## Handy tools
* Size of folder: `du -sh .` `du -sh *`
* Uncompress file: `tar -czvf foobar.tar.gz`
* full-text search: `grep -nrw . -e "[0-9]{3}" --color -i`
* find files at a depth: `find . -maxdepth 2 -name gradle.*service`

## Conflict of line-end
* If using cygwin on windows you will encounter errors like:
    * Invalid expression ^M
    * Invalid '\r' 
* Run `dos2unix` on files
* Turn git global config `core.autocrlf` to false

