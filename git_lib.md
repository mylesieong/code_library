# Git

## Best Practice so far
When I am doing the developement in a project, I always make too many commit so that the reviewer can not really get my logic when they look at the commit history. 
While its inevitable to have such a messy dev branch, I create a branch name *mydev* so that I can have my dirty developement in this branch and when it comes to a push, I checkout to the target branch and **cherry-pick** or **git checkout mydev /path/to/my/fine/file.foobar** to build a beautiful push branch.

## Step to impl best practice
1. Checkout the main branch on which dev is based.
1. Build a branch upon it and name it xxx-mydev
1. Finish feature in xxx-mydev
1. Create another xxx branch upon main branch, cherry pick/checkout files from xxx-mydev
1. (optional) Rebase xxx branch to main branch
1. Create merge request 

## Best Practice so far (cont'd)
Along with development I start to think it over and now I am not sure if I still support this "best practice". Here are some reasons:
1. Move all the change one by one to the target branch takes long time (esp when I checkout the files I spent a lot of time on copying and pasting the path...)
1. By checking out the whole file instead of adding code incrementally, many information lost and it will make future bug fix more difficult.
1. This practice somehow encourage messy development...

