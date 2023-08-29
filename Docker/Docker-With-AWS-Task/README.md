# Hosting a Django Application on AWS EC2 with ALB and RDS MySQL
Welcome to this repository where I'll guide you through the process of creating a small AWS project. We'll cover how to host a Django application on an EC2 instance, connect it to an Application Load Balancer (ALB) as a reverse proxy, and replace the default local SQLite3 database with an RDS MySQL database.
****

- i will use the same django project from the last task so lets build the image 
```
escanor@escanor-virtual-machine:~/Desktop/django$ docker build -t mohannad200210/awsdjango:v2 .
```
- now let's push the django image to dockerhub so we can pull it from the ec2 instance direct
```
escanor@escanor-virtual-machine:~/Desktop/django$ docker push mohannad200210/awsdjango:v2
```

- now lets launch the ec2 instance and give it user data script to launch the django container in it 

- launch the Ec2 instance
  ![image](https://github.com/mohannad200210/Sitech-Internship/assets/95110750/3f26b6d3-066a-491e-b91d-9c4cc13814ce)


- and i used this user data script to launch the django container in it :
```
#!/bin/bash
sudo yum update -y
sudo yum install docker -y

sudo usermod -a -G docker ec2-user
id ec2-user
newgrp docker

pip install mysqlclient

sudo systemctl enable docker.service
sudo systemctl start docker.service


docker pull mohannad200210/awsdjango:v2@sha256:26bd98c1066b178682c63019989cd8128688f09ab32cec8d3b084c3a285d958c
docker container run -p 80:8000 -d -h django-app mohannad200210/awsdjango:v2
```
- now let's create target group and add the EC2 instance to it
![image](https://github.com/mohannad200210/Sitech-Internship/assets/95110750/ff97e533-e9a5-43b8-8e5d-2a262965c51f)

- now lets create security group for the ALB 
![image](https://github.com/mohannad200210/Sitech-Internship/assets/95110750/f303dc72-b9bd-471d-be57-33a4d0a12976)

 - Create ALB and connect the target group to it 
 ![image](https://github.com/mohannad200210/Sitech-Internship/assets/95110750/d8a36b61-2774-4428-84ce-fc29608ab6e4)
 ### and the DNS name for the ALB is : [Django-ALB-1997744320.eu-north-1.elb.amazonaws.com](Django-ALB-1997744320.eu-north-1.elb.amazonaws.com)
- now let's edit the security group of the EC2 instance to receive the http traffic only from the ALB
 ![image](https://github.com/mohannad200210/Sitech-Internship/assets/95110750/ab15a414-d5ce-4988-aff2-81797012f898)

## Connect the Django application with RDS MySql instead of default local SQLite3 : 

- Create RDS MySql
![image](https://github.com/mohannad200210/Sitech-Internship/assets/95110750/7770faa0-748f-462b-8f07-e5bd8a45390e)

- Edit the security group for the RDS MySql to receive traffic from any ip :
![image](https://github.com/mohannad200210/Sitech-Internship/assets/95110750/a21f830d-e38f-4d0e-ba7d-1fefe9149f60)
- connect to the RDS and make Data base called django before the migrations
```
escanor@escanor-virtual-machine:~/Desktop/awsdocker$  mysql -h database-2.cosfhqnaungd.eu-north-1.rds.amazonaws.com -P3306 -u admin -p
Enter password: 
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MySQL connection id is 17
Server version: 8.0.33 Source distribution

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MySQL [(none)]> CREATE DATABASE django;
Query OK, 1 row affected (0.096 sec)
```
-  connect the django container with the RDS and migrate the data bases from django to RDS
```
[ec2-user@ip-172-31-39-48 ~]$ docker container exec -it 3a044 /bin/bash
root@django-app:/app/mysite# apt update
root@django-app:/app/mysite# apt install nano 
root@django-app:/app/mysite# nano mysite/settings.py
then edit the DATABASEs block to :
'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'django',
        'USER': 'admin',
        'PASSWORD': 'Fakepass',
        'HOST': 'database-2.cosfhqnaungd.eu-north-1.rds.amazonaws.com',
        'PORT': '3306',
	'OPTIONS':{
        	'init_command':"SET sql_mode='STRICT_TRANS_TABLES'"}
    }
root@django-app:/app/mysite# python manage.py makemigrations
root@django-app:/app/mysite# python manage.py migrate
```
- Finally let's check if the tables migrated susccessfully
```
 escanor@escanor-virtual-machine:~/Desktop/awsdocker$ mysql -h database-2.cosfhqnaungd.eu-north-1.rds.amazonaws.com -P3306 -u admin -p 
Enter password: 
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MySQL connection id is 34
Server version: 8.0.33 Source distribution

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
5 rows in set (0.091 sec)

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
10 rows in set (0.095 sec)
```





