# Git tips

**Commit only part of a file in Git**

Following: http://stackoverflow.com/questions/1085162/commit-only-part-of-a-file-in-git

```bash

# step1
$ git add --patch fw
# this will walk throught you changes in fw file and ask for a action
# y - add to future commit
# n - to exclude

# If you what to view what to be commited, run:
$ git checkout --

# If all is well, commit
$ git commit

# Go to step1 

# To revert other changes of file and get clear branch(repo) run:
$ git checkout HEAD -- fw

```


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

**View all history(changes) of selected file**

```bash
git log -p roles/default_server.json
```
**Remove branch after merge with master**

```bash
git branch -d look_dmz
```

**View file content in specific revision**

```bash
git show 6aad8f5f47de8b458f7c35b24f9cb099e5fc7e8b:backups/fullserverbackup.sh
```

**Rollback file to revision from HEAD (master)**

```bash
git checkout HEAD -- roles/mimas_cvision_lab.rb
```

**Rollback file to revision from origin/jinja2. This is useful when you have merge conflicts and you know that merged branch has needed file state**

```bash
git checkout origin/jinja2 -- cvl_ldap.py
```


**Create patch from one commit and apply it on other clonned repo from desired remote git url, then commit**

Follow: http://stackoverflow.com/questions/6658313/generate-a-git-patch-for-a-specific-commit

```bash

git format-patch -1 6d2adb1aefed49513cf9ba23ee57daa769602b32
cp 0001.pathc to root dir where file is located

patch -p1 <0001-cvision.lab-modifications-for-load-tickets.patch

```

