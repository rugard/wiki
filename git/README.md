# Git tips

**Remove a branch on the remote (origin) server:**

```bash
git push origin :serverfix
```


**Github update fork**

Follow: http://stackoverflow.com/questions/7244321/how-to-update-github-forked-repository


```bash

 cd chef-cookbooks
 cd nut/
 ls
 git remote -v
 git remote add upstream https://github.com/divergentlogic/cookbooks-nut.git
 git fetch upstream 
 git checkout master 
 git rebase upstream/master 
 git log
 ll
 git push origin master 

```
