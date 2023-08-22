# Docker Tasks : 
- How to Dockerize Nodejs application
- How to Dockerize Django application

and this is my POC :

##  Nodejs and Django Tasks :  


![Creat Placement Group](https://github.com/mohannad200210/Sitech-Internship/blob/261f061a30d270220332e7b95f949fc5cab10540/Daily-Updates%20/Photos/Poc%20node%20dja%202.png)

![Creat Placement Group](https://github.com/mohannad200210/Sitech-Internship/blob/261f061a30d270220332e7b95f949fc5cab10540/Daily-Updates%20/Photos/Poc%20node%20dja.png)

Also i pushed the images to Dockerhub : 
- NodeJs : https://hub.docker.com/repository/docker/mohannad200210/basic-node-js/general
- Django : https://hub.docker.com/repository/docker/mohannad200210/django/general 

and this is the content for the Dockerfile for the two tasks : 
- NodeJs :
```
FROM node:18


WORKDIR /usr/src/app


COPY package*.json ./

RUN npm install

RUN npm ci --omit=dev


COPY . .

EXPOSE 8080
CMD [ "node", "server.js" ]
```

- Django :
```
FROM python:3.7


COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

COPY . code
WORKDIR /code

EXPOSE 8000

ENTRYPOINT ["python", "mysite/manage.py"]
CMD ["runserver", "0.0.0.0:8000"]
```


