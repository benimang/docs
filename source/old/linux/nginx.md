# Nginx 常用配置


## 常用配置

``` conf
server {
    listen 80;
    server_name www.xxx.com;

    location /static {
        alias /data/www/xiao4;
        add_header Access-Control-Allow-Origin *;
        add_header Access-Control-Allow-Headers "Origin, X-Requested-With, Content-Type, Accept";
        add_header Access-Control-Allow-Methods "GET, POST, OPTIONS";
    }

    location ~* ^.*/rs_([\d|a-z]+)_re/.*$ {
        rewrite ^(.*)/rs_([\d|a-z]+)_re/(.*)$ $1/$3?v=$2;
    }
    
    gzip on;
    gzip_min_length 5k;
    gzip_types text/css text/plain application/javascript application/json application/xml image/gif;
}

server {
    listen       443 ssl;    
    server_name www.xxx.com;

    # https 证书
    ssl on;
    ssl_certificate /data/cert/xxx.com.pem;
    ssl_certificate_key  /data/cert/xxx.com.key;

    location /static {
        alias /data/www/xiao4;
        add_header Access-Control-Allow-Origin *;
        add_header Access-Control-Allow-Headers "Origin, X-Requested-With, Content-Type, Accept";
        add_header Access-Control-Allow-Methods "GET, POST, OPTIONS";
    }

    # url rewrite
    location ~* ^.*/rs_([\d|a-z]+)_re/.*$ {
        rewrite ^(.*)/rs_([\d|a-z]+)_re/(.*)$ $1/$3?v=$2;
    }

    # gzip 设置
    gzip on;
    gzip_min_length 5k;
    gzip_types text/css text/plain application/javascript application/json application/xml image/gif;

    # image/png 项目中的资源已经没有压缩效果
    # audio/mpeg 项目中大部分的声音是没有压缩效果，只有一个大文件的背景音乐而已
    # image/jpeg jpeg图片本身就有压缩无需再压缩
}
```


## FastAPI + uvicorn

```
location /server/ {
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_pass http://127.0.0.1:8000/;
    access_log off;
}
```

!!! warning
    要特别注意 `location` 和 `proxy_pass` 两个后面的 `/`