# Using openssl

### Using openssl to create a self signed certificates for authorization http clients on server.

For adjust openssl with default values. See `/etc/openssl.cnf`


**Create the CA Key and Certificate for signing Client Certs**

```bash
openssl genrsa -des3 -out ca.key 4096
openssl req -new -x509 -days 365 -key ca.key -out ca.crt
```

**Generate server and clients keys without password protections**

> Without `-des3`, because we don't proctect private client key with password

```bash
openssl genrsa -out server.key 1024
openssl genrsa -out backup-ldap.key 1024
openssl genrsa -out backup-dns.key 1024
openssl genrsa -out backup-dhcp.key 1024
```

**Creating CSR's**

```
openssl req -new -key server.key -out server.csr
openssl req -new -key backup-ldap.key -out backup-ldap.csr
openssl req -new -key backup-dns.key -out backup-dns.csr
openssl req -new -key backup-dhcp.key -out backup-dhcp.csr
```
****

**Sing all certs: server and clients**

> Attention! Increment serial with a new one cert.

```bash
openssl x509 -req -days 3650 -in server.csr -CA ca.crt -CAkey ca.key -set_serial 01 -out server.crt
openssl x509 -req -days 3650 -in backup-ldap.csr -CA ca.crt -CAkey ca.key -set_serial 02 -out backup-ldap..crt
openssl x509 -req -days 3650 -in backup-dns.csr -CA ca.crt -CAkey ca.key -set_serial 03 -out backup-dns.crt
openssl x509 -req -days 3650 -in backup-dhcp.csr -CA ca.crt -CAkey ca.key -set_serial 04 -out backup-dhcp.crt
```
