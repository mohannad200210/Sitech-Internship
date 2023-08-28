## Description 

### In this repo I will explain how to Create a docker network Within the same network, host a Django application behind an Nginx server acting as a reverse proxy and Connect the Django application with MYSQL Container instead of default local SQLite3

****
## Step 1 : Create a Django application 
- Create the base directory for the application
  
 ```
 escanor@escanor-virtual-machine:~/Desktop$ mkdir Django
 escanor@escanor-virtual-machine:~/Desktop$ cd Django
 ```
- Set up a Virtual Environment
```
escanor@escanor-virtual-machine:~/Desktop/Django$ python3 -m venv mohannad
escanor@escanor-virtual-machine:~/Desktop/Django$ source mohannad/bin/activate
```
- Download the requirements
```
(mohannad) escanor@escanor-virtual-machine:~/Desktop/Django$ echo "Django==2.2.5" > requirements.txt
(mohannad) escanor@escanor-virtual-machine:~/Desktop/Django$ pip install -r requirements.txt
```
- generate the Django project files and directory structure
```
(mohannad) escanor@escanor-virtual-machine:~/Desktop/Django$ django-admin startproject mysite
(mohannad) escanor@escanor-virtual-machine:~/Desktop/Django$ ls
mohannad  mysite  requirements.txt
```
- activate the ALLOWED_HOSTS in settings.py so you can access the app from any ip or domain
```
(mohannad) escanor@escanor-virtual-machine:~/Desktop/Django$ gedit mysite/settings.py
the remove the comment from ALLOWED_HOSTS = ['*']
```
- Run Django locally and make sure it works 
```
(mohannad) escanor@escanor-virtual-machine:~/Desktop/Django$ cd mysite/
(mohannad) escanor@escanor-virtual-machine:~/Desktop/Django/mysite$ python manage.py runserver
```
- now lets write the Docker file to build the Docker image
```
FROM python:3.8@sha256:c3ac277830cfe6d4b092c9e58f6295ac79f6091e7aa602c505e7c887c6b6f513
WORKDIR /app 
COPY ./ ./ 
RUN apt update
RUN pip install -r requirements.txt
EXPOSE 8000
ENTRYPOINT ["python", "mysite/manage.py" , "runserver", "0.0.0.0:8000"]
```
- Build the django docker image
```
(mohannad) escanor@escanor-virtual-machine:~/Desktop/Django$ docker build -t django/app:v1 .
```
****
## Step 2 : Create the Docker network that will host everything 

- Create the network
```
(mohannad) escanor@escanor-virtual-machine:~/Desktop/Django$ docker network create --subnet=10.10.10.0/24 backend
9e1aaabce83954f20c37254ba216539481bc9d4e8026f44f4d4ada1971f77834
```
- Run the Django image on the same network
```
(mohannad) escanor@escanor-virtual-machine:~/Desktop/Django$ docker run --network backend --ip=10.10.10.4 -h django-app -d django/app:v1
cd21ee57dd55556b20dd6c3eb29c82f622e75436cafb7a660d5541c4323f674d
```
![image](https://github.com/mohannad200210/Sitech-Internship/assets/95110750/b725c594-a985-4192-aa65-89f0e22944bb)

****
## Step 3 : host Nginx container acting as a reverse proxy for the Django app

- First you have to Create a directory named nginx-docker and create default nginx config file in it :
```
escanor@escanor-virtual-machine:~/Desktop$ mkdir nginx-docker
escanor@escanor-virtual-machine:~/Desktop$ cd nginx-docker 
escanor@escanor-virtual-machine:~/Desktop/nginx-docker$ gedit default.config
# This is the main Nginx configuration file

# Specify the user and group for Nginx to run as
user www-data;
worker_processes auto;

# Set the error log file and log level
error_log /var/log/nginx/error.log warn;

# Define the events section
events {
    worker_connections 1024;
}

# Define the HTTP server section
http {
    # Set the MIME type mappings
    include /etc/nginx/mime.types;
    
    # Set the default log format
    log_format main '$remote_addr - $remote_user [$time_local] "$request" '
                  '$status $body_bytes_sent "$http_referer" '
                  '"$http_user_agent" "$http_x_forwarded_for"';
    
    # Specify the access log file
    access_log /var/log/nginx/access.log main;

    # Set the server section
    server {
        # Listen on port 80
        listen 80;
        
        # Set the server name
        server_name example.com www.example.com;
        
        # Set the root directory for serving files
        root /var/www/html;
        
        # Define location blocks for handling requests
        location / {
            
        }
        
        # Additional location blocks can be added here for different routes
        
        # Handle error pages
        error_page 404 /404.html;
        error_page 500 502 503 504 /50x.html;
        
        # Specify the location of error pages
        location = /50x.html {
            root /usr/share/nginx/html;
        }
        
        # Enable gzip compression
        gzip on;
        gzip_types text/plain text/css application/javascript image/*;
        
        # Include additional configuration files if needed
        include /etc/nginx/conf.d/*.conf;
    }
}
```

- add proxy pass inside the config file (exactly inside the server block then inside the location block )

```
server {
        # Listen on port 80
        listen 80;
        
        # Set the server name
        server_name example.com www.example.com;
        
        # Set the root directory for serving files
        root /var/www/html;
        
        # Define location blocks for handling requests
        location / {
            proxy_pass http://django-app:8000;
        }
```
- now lets create the docker file for the nginx
```
escanor@escanor-virtual-machine:~/Desktop/nginx-docker$ gedit Dockerfile

FROM nginx:stable@sha256:4a1d2e00b08fce95e140e272d9a0223d2d059142ca783bf43cf121d7c11c7df8
COPY default.config /etc/nginx/conf.d
```
- Build the nginx docker image
```
(mohannad) escanor@escanor-virtual-machine:~/Desktop/nginx-docker$ docker build -t nginx:v1 .
```
- Run the nginx image
```
escanor@escanor-virtual-machine:~/Desktop/nginx-docker$ docker run -itd --network backend --ip=10.10.10.3 -h nginx-app nginx:v1
```
- now the reverse proxy is working and you can edit the config file to add filters or do anything related to the reverse proxy : 
![image](https://github.com/mohannad200210/Sitech-Internship/assets/95110750/5678745e-6daa-44af-ad88-43a1af9b7825)
****
## Step 4 
