**List user key's**

```bash
tdbdump /var/lib/samba/passdb.tdb | grep '[key|data].*ogan'
```

**Clean passwd database from user key's**

```bash
tdbtool /var/lib/samba/passdb.tdb

> delete USER_oganesyan\00
> delete RID_000003ee\00
```

