# Git
* 3 trees are: WorkingDirectory x StagingArea x CommitHistory
* Git is based on changes not snapshot


## Migration



### Teach git diff to understand excel format
1. Add entry to  "/.git/info/attributes": 
       $ *.xlsx diff=git_diff_xlsx
2. Add entry to ".git/config":
       $ [diff "git_diff_xlsx"]
       $       binary = True
       $       textconv = python C:/Users/BI77/Documents/playground/git_diff_xlsx.py
3. Then when run git diff \*.xlsx, git will use given command to generate difference.
** Interesting fact noticed: git_diff_xlsx.py only need 1 file as input, and output stdin, so that I assume that git has its framework to compare 2 file stream. So by understanding this, I can develope my own plugin too!
** The experiment git repo is the "Playground" folder in my BCM working directory
Previously we use python to parse an excel as git-diff's plugin. And now I try to use the liba.exe as the plugin and it works! Only need to change the textconv (in file .git/config) from previous setting: `# textconv = ./liba -show`

### Git understanding
Say A>B>C>D>E is master, A>B>C>G>H is fix, For some reasons, we want to refactor the repo to a linear order (from a so-called "disarray" order), then we perfrom below command to rebase the fix to master base:
$ (at fix branch) git rebase master
then the repo becomes: A>B>C>D>E>G'>H' (the base of fix changed from C to E)
Git introduced the worktree feature not too long ago (as of version 2.5, released July 2015). A great usage scenario can be found here: https://spin.atomicobject.com/2016/06/26/parallelize-development-git-worktrees/
Set up worktree with below command:
$ git worktree add ../new-worktree-dir some-existing-branch

### Local revisioning
$ git show {branch_name/at_least_4_digit_of_commit_SHA1} //show certain commit diff compare to last commit
$ git reflog //system will name the log in format HEAD@{n} so you can easily ref them
$ git show {branch_name/at_least_4_digit_of_commit_SHA1}^  //show previous commit
$ git show {branch_name/at_least_4_digit_of_commit_SHA1}^2  //show 2nd parent (only for merge commit)
$ git show {branch_name/at_least_4_digit_of_commit_SHA1}^^^... //show previous n generation father
$ git show {branch_name/at_least_4_digit_of_commit_SHA1}~n //equivalent to last command

### Fix a corrupted master
1. First of all, assume the wrong tunnel commit cannot/shouldnot merge to head, so steps would be delete the master branch first, and then re-create master branch at the right commit
$ git checkout master
$ git branch wrong_track && git checkout wrong_track  <--- cannot delete master when using it
$ git branch -d master
$ git checkout {master_or_any_other_commit}
$ git branch master

### Handling line ending in cross-OS git project
#### Background
Previously when I am exploring the vim plugin, I ran into the line-end problem the first time. I used vim to set file format to unix and solve adhoc fix. But later it appears that after resetup of cygwin on windows, it regards all file as different version in git due to the line end conflict. Then I try to look for a solution from git.
#### Solution of git 
It provides a git attribute setting that ensure cross OS project align the line ends. Here is how it works:
* __Set in .gitattributes__ 

```
# Set the default behavior, in case people don't have core.autocrlf set.
* text=auto

# Explicitly declare text files you want to always be normalized and converted
# to native line endings on checkout.
*.c text
*.h text

# Declare files that will always have CRLF line endings on checkout.
*.sln text eol=crlf

# Denote all files that are truly binary and should not be modified.
*.png binary
*.jpg binary
```
* __Set in global setting for a linux machine__ `git config --global core.autocrlf input`
* __Set in global setting for a win machine__ `git config --global core.autocrlf true`
> ref: https://help.github.com/articles/dealing-with-line-endings/#platform-all

### Tagging
#### Basic command
`git tag ` //show all tags (both lightweight and annotated)
`git tag v1.1` //lightweight tag HEAD to v1.1
`git tag -a v1.4 -m "my version 1.4"` //build annotated tag v1.4
`git show v1.1` //show the diff between v1.1 and previous commit
#### Concept
There are 2 kinds of tags, lightweight and Annotated. Lightweight tag is like a final branch. Annotated tag is a copy in object tree and might go with key and signature and blablabla.


### Force-push from local to remote
$ git push -f {target_branch_like_origin} {new_of_local_branch}

### Using Local File System as remote
If you want to build a remote repo at local file system, use below command to build a remote repo:
> git init --bare /d/{repo_name}.git
The you can add this as a remote origin (or whatever name) to your current git repo with below cmd:
> git remote add {origin_or_whatever} /d/{repo_name}.git
And so that you can perform same feature to this "remote" just as github like clone/push/pull...

p.s. For more information, refer to: http://www.thehorrors.org.uk/snippets/git-local-filesystem-remotes

### Relationship between "working directory" and "staging area" area
STAGE 本質上 is the product of comparasion between HEAD and WORKDIR. So items in STAGE can be regarded as " actions" basic on HEAD to become WORK. Below command or action is related:
> git add {…}      //move red to green entry in git status that add stuff to head
> git rm {…}       //move red to green entry in git status that remove stuffs from head
> git rm --cached {...}       //move green to red to unstage
> git checkout -- {…}      //move red to nth in git status
> user edit the WORK      //generate red entry in git status


### Working on master but need a quick reference to branch, stash can temp save the change and recover later on
Save dirty workings on branch #1 
> git stash -u    //And now can switch to branch #2, while at this moment branch#1 status is clean 
View Stash:
> git stash list
Recover stash after switch back from branch#2:
> (at branch#1) git stash pop
** note: if stash doesnt cause confliction, it is transferable among different commit.







## Trouble shooting
* {the remote end hung up unexpectly} -> {
    possibly related to http(s).postBuffer, see [post](https://stackoverflow.com/questions/6842687/the-remote-end-hung-up-unexpectedly-while-git-cloning/19286776)
  }
* {fatal: early eof} -> {
    solution: git clone --depth 1 remote,
    reason: guess it happens for git repo w/ submodules
  }

## Config
* To set: `git config --global fookey barvalue`
* To get: `git config --get fookey` 
* Where are the files:
    * OS config file is at /etc/gitconfig
    * User config file is at ~/.gitconfig or ~/.config/git/config
    * Git directory config file is at .git/config

## Git file system convention
1. Ignore file ".gitignore" only effective for local folder 
1. Ignore file "/.git/info/exclude" valid globally in project
1. Attributes file ".gitattributes" and "/.git/info/attributes" are similar

## Ignore
1. Edit {home}/.git/info/exclude to ignore files, Every line regex the file that should (not) be ignored:
    * `*.java`    <- ignore javas globally
    * `# !*.java`  <- don’t ignore java globally
2. Put .gitignore file in any folder to state the ignore target in that folder.
REF-- https://git-scm.com/docs/gitignore
If some files are already under tracking, use below command to remove them from the working area:
> git rm --cached -r target        //recursively remove files under target folder

## Diff
* CHeck diff for a file: `git diff master:index.md develop:index.md`

## Log
* Checkout particular file history: `git log --oneline --stat -- fileA fileB ...`

## Rebase
1. Working on feature branch and develop branch is updated
1. Rewind your work based on the updated develop branch with: `(at feature branch) git rebase develop`

## Squash
1. Squash is to merge N commit to 1 commit.
1. E.g.
	* Squash current branch: `git rebase -i` (i stands for interactive mode) 
	* Squash to 5 commit earlier: `git rebase HEAD~5 -i`
	* Squash from feature to develop: `(at feature branch) git rebase develop -i`
1. In interactive mode keep the first line begining with *pick* and the rest change to *squash*

## Reset
1. Stay at commit & files to unstaged: `git reset HEAD file_to_be_reset`
1. Move 2 commit ahead & keep files (untrack): `git reset HEAD~2` or `git reset --mixed HEAD~2`
1. Move 2 commit ahead & keep files (staged): `git reset --soft HEAD~2`
1. Move 2 commit ahead & files discard: `git reset --hard HEAD~2`

## Submodule
* The submodule folder is just a hash to holder. Submodule's content will not commit to the upper git anyway.  
* When there is git under another git folder, the upper git will regard the deeper git as "Submodule". But not until in upper git invoke command: $ git submodule add {deeper_git} then the upper git will generate the .gitmodule file and start the management of the deeper git module.
* Use `git submodule status` or `vim .gitmodules` to check
* Example: Working on develop branch and want to import a submodule to mysubmodule
    1. `git submodule add https://github.com/<user>/whatever mysubmodule` 
    1. At this point, submodule will still be empty and should run fetch manually: `git submodule update --init --recursive`
* To checkout summit multi-module project:
    1. git clone ssh://sieong@..../stack
    1. cd stack && vim .gitmodules (make sure ssh usernames are good)
    1. git submodule init && git submodule update  
* Commands:
    - git submodule add /path/to/git/name.git
    - git submodule status
    - git submodule init
    - git submodule deinit        // delete the git repo
* How to commit submodule change:
    1. $ cd path/to/submodule
    1. $ git add *
    1. $ git commit -m "comment"
    1. $ git push # or cr
    1. $ cd /main/project
    1. $ git add path/to/submodule
    1. $ git commit -m "updated my submodule"
    1. $ git push # or cr

## Hooks
* Git hooks are scripts that run automatically every time a particular event occurs in a Git repository. 
* Hooks can reside in either local or server-side repositories, and they are only executed in response to actions in that repository
* Hooks reside in the .git/hooks

## Refs and the Reflog
1. Refs is the internal system that git uses to alias commits under the hook of branchs and tags
1. `git show master` equals `git show refs/heads/master` (the former is actually the wrapper of the latter)
1. Look into .git/refs and all the refs structure can be found there
1. Refspecs: A way to manipulate remote branch from local git repo
	* Push a local commit/branch to remote: `git push origin {local_hash}:{your_new_branch_name}` or `git push origin {local_hash}:refs/heads/{your_new_branch_name}`
	* Delete a remote branch: `git push origin :{your_target_branch}`
1. *Operations mentioned above can all be performed with logging onto the git server and do the changing directly*
1. Reflog: A safenet, basically a log of every action so that you can retrieve lost commit hash
	* `git reflog` to check the hash of a detached commit
	* `git checkout HEAD@{n} (or the lost commit hash)` to get back

## How to revert remote branch to previous stats 
1. See Refspecs above

## Stash
1. `git stash`
1. `git stash pop @stash{x}|drop @stash{x}|list`
1. `git stash show @stash{x} -p`
1. `git stash save "your alias to the stash"`

## Trace down history
* git log -5    //Show 5 recent logs
* git log --follow {filename}
* git show {commit hashcode}
* git diff {branchnameA} {branchnameB}
* git log -p {filename}

## Remote basics
* `git remote show` 
```
origin
```
* `git remote -v`           
```
origin https://github…library.git (fetch)
origin https://github…library.git (push)
```
* `git remote add pb https://github.com/paulboone/ticgit && git remote -v`
```
origin https://github.com/schacon/ticgit (fetch)
origin https://github.com/schacon/ticgit (push)
pb https://github.com/paulboone/ticgit (fetch)
pb https://github.com/paulboone/ticgit (push)
```

## Remote branch 
* `git branch -r`
```
origin/HEAD -> origin/master
origin/master
```
* `git push origin master:new_branch && git branch -r ` //Create new branch on remote & push local/master to it 
```
origin/HEAD -> origin/master
origin/new_branch
origin/master
```
## 101
* $git rm {file}
* $git status (-s)
* $git diff
* $git diff --cached
* $git clone https://github.com/mylesieong/my_maven_projects.git
* git checkout {branch name or hashcode}
* git branch
* git branch new_branch
* git branch -d new_branch
* git push origin master 
* git pull origin mastergit push origin master 
* git pull origin mastergit push origin master 
* git pull origin master
* git log --graph --oneline --decorate

## Establish a git repo and push to a remote repo
* $git init
* $git add {file}
* $git config -global user.email "myles.ieong@gmail.com"
* $git config -global user.name "myles"
* $git commit -m "a project name"
* $git remote add origin https://github.com/mylesieong/my_maven_projects.git
* $git push -u origin master //mylesieong:sewshort

## Different Ways to Host Git Server
* Local Protocol: Local File System / Network File System
* SSH Protocol
* Http Protocol
* Git Protocol
* To use Local Protocol
	1. Clone existing project to build: `git clone --bare my_project my_project.git`
	1. Init an Empty project git: `git init --bare new_project.git`

## Turn on git debug messages
1. put these var to 1 by:
```
export GIT_TRACE_PACKET=1
export GIT_TRACE=1
export GIT_CURL_VERBOSE=1
```
1. Run any command for example git clone

# Gerrit
* Gerrit is based on git. Similar to gitlab. Its goal is to add a CI layer and a Review System in a git host.
* When push a commit, gerrit will create a code review contains:
	* A temp branch
	* A CI layer (e.g. a jenkins server build process that feedback to the code review)
	* A review system open to everyone
* If CI layer return positive result and review system rules are met. Then gerrit will merge the branch into target branch. And the temp branch is then removed
* When you push a branch, it will create 1 code review for EVERY commit in your pushed branch. (that is, 1 change-id for 1 code review)
* Read more in [wiki](https://wiki.summit-tech.org/procedures:git:gerrit_developers_guide?s[]=gerrit#squashing_changes)

## How to start a ticket with gerrit
1. Checkout sdk's develop branch
1. Do you change without having to create new branch (because gerrit will create temp branch anyway) 
1. Squash your changes to 1 commit
1. Push with `git cr develop` (note: don't create and push to feature branch. git cr doesn't support pushing to feature branch)
1. Done

## How to make follow up change
1. Back to last change commit
1. Do changes
1. Use `git commit --amend` to patch your changes but keeps the previous change-id at the same time
1. Push again with `git cr develop`
