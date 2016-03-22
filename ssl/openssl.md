# Using openssl

### Using openssl to create a self signed certificates for authorization http clients on server.


**Create the CA Key and Certificate for signing Client Certs**

```bash
openssl genrsa -des3 -out ca.key 4096
openssl req -new -x509 -days 365 -key ca.key -out ca.crt
```

**Create the Server Key, CSR, and Certificate**

```bash
openssl genrsa -des3 -out server.key 1024
openssl req -new -key server.key -out server.csr
```

**We're self signing our own server cert here.  This is a no-no in production.**

> Attention

```bash
openssl x509 -req -days 3650 -in server.csr -CA ca.crt -CAkey ca.key -set_serial 01 -out server.crt
```

****

> Without `-des3`, because we don't proctect private client key with password

```bash
openssl genrsa -out backup-ldap.key 1024
```
