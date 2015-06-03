# Managing system users and groups

** True recreating user:**

Delete user from passwd and shadow.

Add with adduser:

```bash
adduser wsadm --uid 1000 --gid 1000
```

**Remove password for selected user (secure root accout in ubuntu):**

```bash
passwd -d root
```

