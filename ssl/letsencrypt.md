Lets encrypt
===========

Add a new cert for a new service:

```
certbot -d asda.cvisionlab.com
```


I has succesfully setup let's encrypt on gate with following article **under root account**

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
pip uninstall certbot

apt-get install software-properties-common
add-apt-repository ppa:certbot/certbot
apt update
apt-get install python-certbot-nginx
hash -r
certbot --version


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
# Setup autoupdate via crontab:

```
# New true command for auto update certs in cron
# -q  - quite
# -n - non interactive (useful for cron)
6  6,18 * * * root  certbot renew -nq --post-hook "service nginx reload"
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
