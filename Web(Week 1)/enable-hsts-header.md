# Enable HSTS Header

sudo gedit /etc/nginx/nginx.conf

Add this line to the same block of the file containing the SSL ciphers in order to enable HSTS:

{% code fullWidth="true" %}
```markup
server {
...
    ssl_ciphers EECDH+CHACHA20:EECDH+AES128:RSA+AES128:EECDH+AES256:RSA+AES256:EECDH+3DES:RSA+3DES:!MD5;
    add_header Strict-Transport-Security "max-age=15768000" always;
}
...
```
{% endcode %}

then check the syntax and restart the server :&#x20;

```
sudo nginx -t
sudo systemctl restart nginx

```
