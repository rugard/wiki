Lets encrypt
===========


I has succesfully setup let's encrypt on gate with following article **under root account**

http://habrahabr.ru/post/270273/

Links from goncharov:

https://habrahabr.ru/post/279695/
https://habrahabr.ru/post/304174/

New Automatic, since 2017-30-May:

```
cd /srv/nginx-confd-gate/
certbot --nginx -d chef.cvisionlab.com
git diff
git checkout -- chef.conf
```

New Automatic:

prep a sys:
```
pip install -U pip
pip install certbot
pip install -U certbot
pip install -U certbot-nginx

certbot cerrificates
# You should see existing manual recived certs on you server
```

to auto update:

```
certbot renew --nginx --dry-run
certbot renew --nginx
# select expired cert, enter
```

to delete a cert interactively:

```
certbot delete
# select expired cert, enter
```


DEPRECATED - manual. To update a cert or generate a new one use following alg:

```bash
sudo su
cd /srv/ssl/letsencrypt
./letsencrypt-auto --agree-dev-preview --server \https://acme-v01.api.letsencrypt.org/directory -a manual auth
```

Enter one domain name (of new or existing obsolete cert)

Next follow instructions in console.

In a separate console run as root:

```bash
service stop nginx

mkdir -p /tmp/letsencrypt/public_html/.well-known/acme-challenge
cd /tmp/letsencrypt/public_html
printf "%s" Yb_lT6NYCI-XBelvY4c2iOhTHal-COpFDCiTpOXeQDw.puUDQkZNVJSazmRRopayEg7UtrzPSudZPKspaAVXcvk > .well-known/acme-challenge/Yb_lT6NYCI-XBelvY4c2iOhTHal-COpFDCiTpOXeQDw

$(command -v python2 || command -v python2.7 || command -v python2.6) -c \
"import BaseHTTPServer, SimpleHTTPServer; \
s = BaseHTTPServer.HTTPServer(('', 80), SimpleHTTPServer.SimpleHTTPRequestHandler); \
s.serve_forever()"

# ensure you press enter and server validated, CTRL+C

service start nginx
```

Check new/updated cert's in ```/etc/letsencrypt/live/```
