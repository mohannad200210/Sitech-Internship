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

- First you have to Create a directory named nginx-docker:
```
escanor@escanor-virtual-machine:~/Desktop$ mkdir nginx-docker
escanor@escanor-virtual-machine:~/Desktop$ cd nginx-docker 

```

- create default nginx config file in it and add proxy pass inside the config file (exactly inside the server block then inside the location block )

```
escanor@escanor-virtual-machine:~/Desktop/nginx-docker$ gedit default.config

server {
    listen 80;
    server_name example.com;

    location / {
        proxy_pass http://django-app:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}

```
- now lets create the docker file for the nginx
```
escanor@escanor-virtual-machine:~/Desktop/nginx-docker$ gedit Dockerfile

FROM nginx:stable@sha256:4a1d2e00b08fce95e140e272d9a0223d2d059142ca783bf43cf121d7c11c7df8
FROM nginx:stable
COPY default.conf /etc/nginx/conf.d/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

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
## Step 4 : Create MySql Container and connect it with the Django App

- Create MySql Container and pass the correct enviroment variables to it
```
escanor@escanor-virtual-machine:~/Desktop/tmp/mysite/mysite$ docker run --network backend --ip 10.10.10.7 --name app-mysql -v /home/escanor/Desktop/volume:/etc/mysql/conf.d -e MYSQL_ROOT_PASSWORD=FakePass -e MYSQL_USER=django -e MYSQL_PASSWORD=FakePass -d mysql:8.1.0@sha256:eb00f19a38312b85bfb7195eead2d07d35279f2a6a61b3dc994094dcefa57986
```
-Connect to the Mysql as root and give the permission to the django user to create tables and all other operations 
```
(mohannad) escanor@escanor-virtual-machine:~/Desktop/tmp$ mysql -h 10.10.10.7 -uroot -p
Enter password: 
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MySQL connection id is 11
Server version: 8.1.0 MySQL Community Server - GPL

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MySQL [(none)]> GRANT ALL PRIVILEGES ON *.* TO 'django'@'%' WITH GRANT OPTION;
Query OK, 0 rows affected (0.008 sec)

MySQL [(none)]> EXIT
Bye
(mohannad) escanor@escanor-virtual-machine:~/Desktop/tmp$ mysql -h 10.10.10.7 -udjango -p
Enter password: 
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MySQL connection id is 12
Server version: 8.1.0 MySQL Community Server - GPL

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MySQL [(none)]> create DATABASE django;
Query OK, 1 row affected (0.005 sec)

MySQL [(none)]> show databases;
+--------------------+
| Database           |
+--------------------+
| django             |
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
5 rows in set (0.007 sec)
```
- Update the database information in the Django app
```
escanor@escanor-virtual-machine:~/Desktop/tmp$ gedit mysite/mysite/settings.py
 
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'django',
        'USER': 'django',
        'PASSWORD':'Pa55W0rd',
        'HOST':'10.10.10.7',
        'PORT':'3306',
        'OPTIONS':{
        	'init_command':"SET sql_mode='STRICT_TRANS_TABLES'"}
    }
}
```
- Edit The Dockerfile to Run migrations during image build (this step don't works so i did the migrations from inside the container in the next step ) 
```
escanor@escanor-virtual-machine:~/Desktop/tmp$ gedit Dockerfile

FROM python:3.8@sha256:c3ac277830cfe6d4b092c9e58f6295ac79f6091e7aa602c505e7c887c6b6f513
WORKDIR /app 
COPY ./ ./ 
RUN apt update -y
RUN pip install -r requirements.txt
RUN pip install mysqlclient
RUN python mysite/manage.py migrate
EXPOSE 8000
ENTRYPOINT ["python", "mysite/manage.py" , "runserver", "0.0.0.0:8000"]
```
- rebuild the Django image and
```
escanor@escanor-virtual-machine:~/Desktop/tmp$ docker build -t django-app:v2 .
```
- run new container and migrate the data bases 
```
escanor@escanor-virtual-machine:~/Desktop/tmp$ docker run --network backend --ip=10.10.10.4 -h django-app -d django-app:v2
89e4eeef9c2d5e291a816f8bf393c620e5bad525f0de4bccd54f75ca448bae73
escanor@escanor-virtual-machine:~/Desktop/tmp$ docker container exec -it 89e /bin/bash
root@django-app:/app# ls
Dockerfile  mohannad2  mysite  requirements.txt
root@django-app:/app# cd m
mohannad2/ mysite/    
root@django-app:/app# cd mysite/
root@django-app:/app/mysite# python manage.py migrate
Operations to perform:
  Apply all migrations: admin, auth, contenttypes, sessions
Running migrations:
  Applying contenttypes.0001_initial... OK
  Applying auth.0001_initial... OK
  Applying admin.0001_initial... OK
  Applying admin.0002_logentry_remove_auto_add... OK
  Applying admin.0003_logentry_add_action_flag_choices... OK
  Applying contenttypes.0002_remove_content_type_name... OK
  Applying auth.0002_alter_permission_name_max_length... OK
  Applying auth.0003_alter_user_email_max_length... OK
  Applying auth.0004_alter_user_username_opts... OK
  Applying auth.0005_alter_user_last_login_null... OK
  Applying auth.0006_require_contenttypes_0002... OK
  Applying auth.0007_alter_validators_add_error_messages... OK
  Applying auth.0008_alter_user_username_max_length... OK
  Applying auth.0009_alter_user_last_name_max_length... OK
  Applying auth.0010_alter_group_name_max_length... OK
  Applying auth.0011_update_proxy_permissions... OK
  Applying sessions.0001_initial... OK
root@django-app:/app/mysite# 
```
- Finally let's check if the data migrated susccessfully
```
escanor@escanor-virtual-machine:~/Desktop/tmp$ mysql -h 10.10.10.7 -udjango -p
Enter password: 
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MySQL connection id is 16
Server version: 8.1.0 MySQL Community Server - GPL

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MySQL [(none)]> show databases;
+--------------------+
| Database           |
+--------------------+
| django             |
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
5 rows in set (0.002 sec)

MySQL [(none)]> use django;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
MySQL [django]> show tables;
+----------------------------+
| Tables_in_django           |
+----------------------------+
| auth_group                 |
| auth_group_permissions     |
| auth_permission            |
| auth_user                  |
| auth_user_groups           |
| auth_user_user_permissions |
| django_admin_log           |
| django_content_type        |
| django_migrations          |
| django_session             |
+----------------------------+
10 rows in set (0.002 sec)
```
