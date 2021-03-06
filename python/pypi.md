Suppose you have done you project and sdist command is done successfully.

First time you must register on pypi:

```
python setup.py register

running register
running egg_info
writing requirements to cvlops.egg-info/requires.txt
writing cvlops.egg-info/PKG-INFO
writing top-level names to cvlops.egg-info/top_level.txt
writing dependency_links to cvlops.egg-info/dependency_links.txt
reading manifest file 'cvlops.egg-info/SOURCES.txt'
writing manifest file 'cvlops.egg-info/SOURCES.txt'
running check
We need to know who you are, so please choose either:
 1. use your existing login,
 2. register as a new user,
 3. have the server generate a new password for you (and email it to you), or
 4. quit
Your selection [default 1]: 
2
Username: vskubriev
Password: 
 Confirm: 
   EMail: skubriev@cvisionlab.com
Registering vskubriev to https://pypi.python.org/pypi
You will receive an email shortly.
Follow the instructions in it to complete registration.
```

Next you must confirm a registration, by following link in email.

Only after confirming you account you can continue. Call register command again.

```
skubriev@mimas[~/cvlops-python][0] $ python setup.py register

running register
running egg_info
writing requirements to cvlops.egg-info/requires.txt
writing cvlops.egg-info/PKG-INFO
writing top-level names to cvlops.egg-info/top_level.txt
writing dependency_links to cvlops.egg-info/dependency_links.txt
reading manifest file 'cvlops.egg-info/SOURCES.txt'
writing manifest file 'cvlops.egg-info/SOURCES.txt'
running check
We need to know who you are, so please choose either:
 1. use your existing login,
 2. register as a new user,
 3. have the server generate a new password for you (and email it to you), or
 4. quit
Your selection [default 1]: 
1
Username: vskubriev
Password: 
Registering cvlops to https://pypi.python.org/pypi
Server response (200): OK
I can store your PyPI login so future submissions will be faster.
(the login will be stored in /home/skubriev/.pypirc)
Save your login (y/N)?y
```

This will be finished yor registration and save credentials in `~/.pypirc`

```
skubriev@mimas[~/cvlops-python][0] $ python setup.py sdist upload
running sdist
running egg_info
writing requirements to cvlops.egg-info/requires.txt
writing cvlops.egg-info/PKG-INFO
writing top-level names to cvlops.egg-info/top_level.txt
writing dependency_links to cvlops.egg-info/dependency_links.txt
reading manifest file 'cvlops.egg-info/SOURCES.txt'
writing manifest file 'cvlops.egg-info/SOURCES.txt'
running check
creating cvlops-1.0
creating cvlops-1.0/cvlops
creating cvlops-1.0/cvlops.egg-info
creating cvlops-1.0/cvlops/mail
making hard links in cvlops-1.0...
hard linking README.txt -> cvlops-1.0
hard linking setup.cfg -> cvlops-1.0
hard linking setup.py -> cvlops-1.0
hard linking cvlops/__init__.py -> cvlops-1.0/cvlops
hard linking cvlops.egg-info/PKG-INFO -> cvlops-1.0/cvlops.egg-info
hard linking cvlops.egg-info/SOURCES.txt -> cvlops-1.0/cvlops.egg-info
hard linking cvlops.egg-info/dependency_links.txt -> cvlops-1.0/cvlops.egg-info
hard linking cvlops.egg-info/requires.txt -> cvlops-1.0/cvlops.egg-info
hard linking cvlops.egg-info/top_level.txt -> cvlops-1.0/cvlops.egg-info
hard linking cvlops/mail/__init__.py -> cvlops-1.0/cvlops/mail
hard linking cvlops/mail/cvl_mail.py -> cvlops-1.0/cvlops/mail
copying setup.cfg -> cvlops-1.0
Writing cvlops-1.0/setup.cfg
Creating tar archive
removing 'cvlops-1.0' (and everything under it)
running upload
Submitting dist/cvlops-1.0.tar.gz to https://pypi.python.org/pypi
Server response (200): OK
```

This will be published package version to main pipy index.
