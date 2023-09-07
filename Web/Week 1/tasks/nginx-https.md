---
description: Nginx HTTPS host
---

# Nginx https

Generate a Self-Signed SSL/TLS Certificate

`sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/self-signed.key -out /etc/nginx/self-signed.crt`

add the following lines to configure HTTPS:

`sudo nano /etc/nginx/sites-available/defaul`t



Inside the file add :

```
server {
    listen 80;
    server_name localhost;

    location / {
        return 301 https://$host$request_uri;
    }
}

server {
    listen 443 ssl;
    server_name localhost;

    ssl_certificate /etc/nginx/self-signed.crt;
    ssl_certificate_key /etc/nginx/self-signed.key;

    location / {
        # Your web application configuration goes here
    }
}

```

Enable the Nginx Configuration

`sudo ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/`&#x20;

Test the Nginx Configuration

```
sudo nginx -t
```

restart nginx

```
sudo systemctl reload nginx
sudo systemctl stop nginx
sudo systemctl start nginx

```
