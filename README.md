# Wiki for sysadmins

## This wiki is drop-in replacement for google doc linux_notes.

For read wiki navigate to wiki section of this site.

https://github.com/rugard/doc/wiki

## Setting up sysadmin workflow

```bash
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.last 'log -1 HEAD'
git config --global alias.pom 'push origin master'
git config --global alias.aa 'add --all :/'

git config user.name "Vladimir Skubriev"
git config user.email "<skubriev@cvisionlab.com>"
# or private
git config user.email "<vladimir@skubriev.com>"
git config --global core.editor vim
git config --global merge.tool vimdiff
git config --global color.ui auto

git config --list
```
# Setting up environment

```bash
update-alternatives --list editor
update-alternatives --set editor /usr/bin/vim.basic
```

