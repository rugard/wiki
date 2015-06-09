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
## 4. Generate ssh key

```bash
ssh-keygen -t rsa -f customscripts_deploy_key -N ''
xclip -sel clip <customscripts_deploy_key.pub
```
