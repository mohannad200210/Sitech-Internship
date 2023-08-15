# Docker Engine

Docker Demon (Docker Server)<------>Rest API  <------>Docker cli

## &#x20;Docker objects :&#x20;

* **Docker Image** : A Docker image is a lightweight, read-only template that contains a base image of Os system or application like web server or db
* **Docker Container :** A Docker container is read-write template , runnable instance version created from a Docker image. It's an isolated and self-sufficient environment that contains the application and all its dependencies. Containers run on the host operating system but are isolated from each other and from the host system.&#x20;
* **Docker Networks:** Docker networks provide a way for containers to communicate with each other or with external networks while maintaining isolation.
* **Docker Volumes:** Docker volumes are mechanisms for persistently storing data generated by containers or for sharing data between containers and the host system. Containers are designed to be stateless and ephemeral, meaning that their data doesn't persist after they're stopped or destroyed. Volumes provide a way to overcome this limitation by allowing data to be stored externally from the container and shared between containers if necessary. Volumes are particularly useful for databases, file storage, or any scenario where data persistence is required.

## ------------------------------------------------------------------------------------------------------------------------------------

## &#x20;A Docker registry :&#x20;

&#x20;is a central repository that stores and manages Docker images. It's a service that allows you to upload, store, and share Docker images with others. Docker images can be quite large, especially when they contain all the dependencies and runtime environments required for an application.

A Docker registry :&#x20;

* public  (Docker Trusted Registry (DTR) and Docker hub)
* private&#x20;

## ------------------------------------------------------------------------------------------------------------------------------------

## Docker Engine Architecture

<figure><img src=".gitbook/assets/Docker engine architecture.png" alt=""><figcaption></figcaption></figure>

## ------------------------------------------------------------------------------------------------------------------------------------&#x20;

When you try to run ubuntu image, you can't why? Because docker is not designed for hosting an operating system&#x20;

but docker only meant to run specific task or process such : running instance of web server or data base or application server

The container only lives when the process inside it is alive when the process <mark style="color:purple;">crash</mark> or <mark style="color:yellow;">die</mark> or <mark style="color:green;">stopped</mark> the <mark style="color:red;">container will exits</mark>&#x20;

<pre><code>docker container run ubuntu
Unable to find image 'ubuntu:latest' locally
latest: Pulling from library/ubuntu
2746a4a261c9: Pull complete
4c1d20cdee96: Pull complete
0d3160e1d0de: Pull complete
c8e37668deea: Pull complete
Digest: sha256:250cc6f3f3ffc5cdaa9d8f4946ac79821aafb4d3afc93928f0de9336eba21aa4
Status: Downloaded newer image for ubuntu:latest
docker container ls -a
CONTAINER ID IMAGE COMMAND CREATED STATUS PORTS NAMES
d969ecdb44ea ubuntu "/bin/bash" 2 minutes ago <a data-footnote-ref href="#user-content-fn-1">Exited (0) 2 m</a>inutes ago intelligent_almeida
</code></pre>

instead of run ubuntu image we can run process inside ubuntu image using options&#x20;

now we will run shell inside ubuntu

\-t : terminal&#x20;

\-i : interactive&#x20;

```
docker container run -it ubuntu
root@6caba272c8f5:/#
root@6caba272c8f5:/# hostname
6caba272c8f5
root@6caba272c8f5:/#
```

note : options before container name passing to container&#x20;

options after container name passing to as container&#x20;

[^1]: 