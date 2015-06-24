# Manage system packages

** Clean packages list cache**

```bash
$ sudo rm -r /var/cache/apt /var/lib/apt/lists
$ sudo apt-get update #takes a while re-fetching everything
$ sudo apt-get install <some-random-package>
```

Following: http://serverfault.com/questions/368669/debian-ubuntu-is-it-possible-to-reinitialize-var-lib-apt-lists-and-var-apt-cac
