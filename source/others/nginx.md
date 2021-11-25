# Nginx 常用配置

## URL Rewrite

```
server {
    location ~* ^.*/rs_([\d|a-z]+)_re/.*$ {
        rewrite ^(.*)/rs_([\d|a-z]+)_re/(.*)$ $1/$3?v=$2;
    }
}
```