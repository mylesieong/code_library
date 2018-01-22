# Git

## Best Practice so far
When I am doing the developement in a project, I always make too many commit so that the reviewer can not really get my logic when they look at the commit history. 
While its inevitable to have such a messy dev branch, I create a branch name *mydev* so that I can have my dirty developement in this branch and when it comes to a push, I checkout to the target branch and **cherry-pick** or **git checkout mydev /path/to/my/fine/file.foobar** to build a beautiful push branch.
