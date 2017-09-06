# Wiki for sysadmins

## This wiki is drop-in replacement for google doc linux_notes.

For read wiki navigate to wiki section of this site.

https://github.com/rugard/doc/wiki

## Setting up sysadmin workflow

```bash
git config --global alias.co checkout; \
git config --global alias.br branch; \
git config --global alias.ci commit; \
git config --global alias.st status; \
git config --global alias.last 'log -1 HEAD'; \
git config --global alias.pom 'push origin master'; \
git config --global alias.aa 'add --all :/'

git config user.name "Vladimir Skubriev"; \
git config user.email "<skubriev@cvisionlab.com>"; \
# or private
git config user.email "<vladimir@skubriev.com>"; \
git config --global core.editor vim; \
git config --global merge.tool vimdiff; \
git config --global color.ui auto

git config --list
```
# Setting up environment

```bash
update-alternatives --list editor
update-alternatives --set editor /usr/bin/vim.basic
```

# bash PS1

on servers, user - user and host are green:
```
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@$(hostname -f)\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
```

on servers, root - red user:
```
PS1='${debian_chroot:+($debian_chroot)}\[\033[38;5;9m\]\u\[\033[01;32m\]@$(hostname -f)\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
```
