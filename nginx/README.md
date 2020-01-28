# ngninx

**telnet не умеет https/443**

```
telnet yandex.ru 80
<Enter>
GET /index.html HTTP/1.0
<Enter>
```

```

```

Header host (появился в HTTP/1.1)
HTTP = Method + URL

```
curl -D headers.txt
curl -D -console -
curl -H 'Host:yandex.ru'
```

Нужно изучать все хэдеры. Например есть `Cache-Control:`, `X-API-KEY 123;`

cache-control always-reload


```
default_server {
  # - нужен везде, например:
  location / {
    return 403;
  }
}
```

# rewrite

> worker обрабатывает метод CONNECT

nginx берёт полученный URL, переделывает URL согласно rewrite и делает CONNECT к внутреннему серверу.
rewrite зависит от запроса URL пользователем (мы хотим переписать URL)

