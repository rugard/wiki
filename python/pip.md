# Using pip

## Upgrade pip on a fresh installed ubuntu

System default pip is obsolete in ubuntu. To upgrade use following commands:

Short commmand list to achive a goal ;) :

```
sudo pip install -U pip
hash -r
```

In the details:

When you upgrade pip, it will install new pip version in `/usr/local/bin/`.
Since `/usr/local/bin/` occurs early in $PATH, then system will be using upgraded version.
But we need to rehash system path with `hash -r` for apply changes in current terminal.

```
which pip
/usr/bin/pip
pip -V

pip 1.5.4 from /usr/lib/python2.7/dist-packages (python 2.7)

sudo pip install -U pip

which pip
/usr/local/bin/pip

pip -V
pip 1.5.4 from /usr/lib/python2.7/dist-packages (python 2.7)

hash -r

/usr/local/bin/pip -V
pip 8.1.0 from /usr/local/lib/python2.7/dist-packages (python 2.7)
```
