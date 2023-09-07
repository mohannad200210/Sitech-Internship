# Host a default Nginx Server

sudo apt install nginx

### &#x20;Adjusting the Firewall :thumbsup:

sudo ufw allow 'Nginx HTTP'



## start Nginx

```
sudo systemctl stop apache2
```

```
sudo systemctl start nginx
```

```
 sudo systemctl restart nginx
```

<pre data-full-width="true"><code><strong>the problim was i actully stop apache and start nginx but when i open the local host its still apache
</strong></code></pre>

{% code fullWidth="true" %}
```
first let's check what happen in the port 80 
```
{% endcode %}

{% code fullWidth="true" %}
```
 lsof -i -P -n | grep LISTEN #https://explainshell.com/explain?cmd=sudo+lsof+-i+-P+-n+%7C+grep+LISTEN
```
{% endcode %}

```
 OR
```

{% code fullWidth="true" %}
```
 nmap -A 192.168.122.1
```
{% endcode %}

```
nginx is active but the front-end still apache 
```

```
lets check web root directory 
```

{% code fullWidth="true" %}
```
there is index.html file that have the html of apache just remove it and the issue will solve
```
{% endcode %}

```
```
