# ADD CUSTOM HEADER IN NGINX

```
sudo nano /etc/nginx/sites-available/default

```

add this inside http or https or both as you want&#x20;

```
 add_header Zeyad-AbuLaban "Meow";
```

then check the syntax and restart the server :&#x20;

```
sudo nginx -t
sudo systemctl restart nginx

```
