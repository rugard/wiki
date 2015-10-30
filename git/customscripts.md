# Manage customscripts repo with git

## 1. Clear remotes on all machines

```bash
git remote -v
git remote remove origin
git remote add origin ssh://git@bitbucket-customscripts/cvisionlabops/customscripts.git
git remote -v
```

## 2. Reorganize clonned customscripts. Add new remote origin, which is on bitbucket now:

* add remote branch to fetch:

```bash
git remote add origin ssh://git@bitbucket-customscripts/cvisionlabops/customscripts.git
```

* fetch

```bash
git fetch origin master
```

* checkout

```bash
git checkout master
```

## 3. For Development. Add new remote origin(for pushing changes), which is on bitbucket now:

* add remote branch to where you can push:

```bash
git remote add https https://vskubriev@bitbucket.org/cvisionlabops/customscripts.git
```

* push changes to master

```bash
git push https master
```

* you can done something changes with pull request model, as konovalov says.

```
git checkout -b feature1_branch
git ci 
git push https feature1_branch
```
* go to the bitbucket/github, create a pull request from feature1_branch to master, approve this pull request. this will be done to make a local master like a remote master.

```
git checkout master
git branch -d feature1_branch
git pull origin master
```

## 4. Generate ssh key

```bash
ssh-keygen -t rsa -f customscripts_deploy_key -N ''
xclip -sel clip <customscripts_deploy_key.pub
```

## 5. Add build server remote

```
git remote add build git@build.cvision.lab:customscripts.git
```
