# Git
* 3 trees are: WorkingDirectory x StagingArea x CommitHistory
* Git is based on changes not snapshot

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
1. The submodule folder is just a hash to holder. Use `git submodule status` or `vim .gitmodules` to check
1. Working on develop branch and want to import a submodule to mysubmodule
1. `git submodule add https://github.com/<user>/whatever mysubmodule` 
1. At this point, submodule will still be empty and should run fetch manually: `git submodule update --init --recursive`

## Hooks
* Git hooks are scripts that run automatically every time a particular event occurs in a Git repository. 
* Hooks can reside in either local or server-side repositories, and they are only executed in response to actions in that repository
* Hooks reside in the .git/hooks

## Refs and the Reflog
**TODO** see https://www.atlassian.com/git/tutorials/refs-and-the-reflog

## How to revert remote branch to previous stats 
**TODO**

## Stash
1. `git stash`
1. `git stash pop @stash{x}|drop @stash{x}|list`
1. `git stash show @stash{x} -p`

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
