# Bash

## Handy tools
* du -sh .` `du -sh *   //Size of folder
* df    //Size of file system
* tar (--exclude='.git') -czvf foobar.tar.gz  //Tar compress file
* tar -xzvf foobar.tar.gz   //Tar uncompress file
* grep -nrw . -e "[0-9]{3}" --color -i  //full-text search with color highline and ignoring cases
* find . -maxdepth 2 -name build.gradle  //find files at a depth
* tree . -L 3

## Conflict of line-end
* If using cygwin on windows you will encounter errors like:
    * Invalid expression ^M
    * Invalid '\r' 
* Run `dos2unix` on files
* Turn git global config `core.autocrlf` to false

## Trouble shooting "command not found"
* Scenes: gradle daemon in jenkins server cannot reach root path | script cannot find `java` command | in any shell command not found
* Root cause: the PATH that passes to the worker object doesn't contain the cmd. If you can get correct PATH on testing env but not on production env, then they have diff PATH
* Case: When running a script, in script for example `java` can be not able to found because the path is somehow not passed to the script. We can create a link toward the target command to make it work: In ~/usr/bin, run `ln -s -f $JRE_HOME/bin/java`

## General command
* Check last cmd result: echo $?
* Make cmd result 0 even it goes wrong: rm folder/ || true
