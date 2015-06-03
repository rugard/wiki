
[SSH Tunnels](tunnel.md)

**Generate strong ssh key**

```bash
ssh-keygen -f .ssh/id_rsa -C skubriev@cvisionlab.com -o -a 1000 -b 4096

```

**Prints the contents of a certificate, view bits. **

```bash
skubriev@mimas:~$ ssh-keygen -l -f ~/.ssh/id_rsa.pub 
2048 40:97:53:10:7e:81:e0:7c:47:1e:f9:f6:37:b2:11:08  skubriev@mimas (RSA)
```


