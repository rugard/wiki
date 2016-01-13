Lets encrypt
===========


I has succesfully setup let's encrypt on gate with following article **under root account**

http://habrahabr.ru/post/270273/

To update a cert or generate a new one use following alg:

```bash
sudo su
cd /srv/ssl/letsencrypt
./letsencrypt-auto --agree-dev-preview --server \https://acme-v01.api.letsencrypt.org/directory -a manual auth
```

Enter one domain name (of new or existing obsolete cert)

Next follow instructions in console.

In a separate console run as root:

```bash
mkdir -p /tmp/letsencrypt/public_html/.well-known/acme-challenge
cd /tmp/letsencrypt/public_html
printf "%s" Yb_lT6NYCI-XBelvY4c2iOhTHal-COpFDCiTpOXeQDw.puUDQkZNVJSazmRRopayEg7UtrzPSudZPKspaAVXcvk > .well-known/acme-challenge/Yb_lT6NYCI-XBelvY4c2iOhTHal-COpFDCiTpOXeQDw

$(command -v python2 || command -v python2.7 || command -v python2.6) -c \
"import BaseHTTPServer, SimpleHTTPServer; \
s = BaseHTTPServer.HTTPServer(('', 80), SimpleHTTPServer.SimpleHTTPRequestHandler); \
s.serve_forever()"
```

Check new/updated cert's in ```/etc/letsencrypt/live/```
