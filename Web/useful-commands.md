# useful commands



[https://www.digitalocean.com/community/tutorials/how-to-install-nginx-on-ubuntu-22-04](https://www.digitalocean.com/community/tutorials/how-to-install-nginx-on-ubuntu-22-04)

To stop your web server, type:

```
sudo systemctl stop nginx/apachie

```

To start the web server when it is stopped, type:

```
sudo systemctl start nginx

```

To stop and then start the service again, type:

<pre><code> sudo systemctl restart nginx
<strong>the problim was i actully stop apache and start nginx but when i open the local host its still apache
</strong>first let's check what happen in the port 80 
 lsof -i -P -n | grep LISTEN #https://explainshell.com/explain?cmd=sudo+lsof+-i+-P+-n+%7C+grep+LISTEN
 OR
 nmap -A 192.168.122.1
nginx is active but the front-end still apache 
lets check web root directory 
there is index.html file that have the html of apache just remove it and the issue will solve

</code></pre>
