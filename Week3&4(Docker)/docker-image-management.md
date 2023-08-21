# Docker image management

Image Registry: general image repository&#x20;

Docker hub : The default public registry where all images are stored is known as Docker Hub. You can create public or private images on Docker Hub. You can create your own images, and push to Docker Hub



you may need to have your own internal Docker registry that can be hosted within your organization. In that case, you may deploy your own version of Docker registry within your organization using the Docker :&#x20;

* Docker Trusted Registry&#x20;
* Google Container Registry
* Amazon Container Registry
* Azure Container Registry



when you pull you can specify the version by tags

```
docker run ubuntu:latest
docker run ubuntu:18.04
docker run ubuntu:trusty
```

List Local Available Images

```
docker image ls
```

image search without GUI result&#x20;

```
docker search httpd
#only give me the first 2 result
docker search httpd --limit 2
#only give the images with more than 10 stars
docker search --filter stars=10 httpd
#only give the images from official resources with more than 10 stars
docker search --filter stars=10 --filter is-official=true httpd
```

pull image and save it locally without create a container from it now

```
docker image pull httpd
```

\-------------------------------------------------

when you deal with image you have to specify the registry and the user who create the imafor the image like this :&#x20;

image name --> registry/user/imagename

```
docker image pull docker.io/httpd/httpdhttpd
docker image pull gcr.io/organization/ubuntu
```

but if you don't specify it by default  it will be :&#x20;

username = image name&#x20;

registry= docker.io (docker hub)

\----------------------------------------------------

you cant push image to private or public registry without login

you cant pull image from private registry without login

who to login?

```
docker login docker.io
docker login gcr.io
```

\-------------------------------------------------

### retag :

create image copy (it's actually not a copy it's only a <mark style="color:red;">soft link</mark> with the same ID but but with different TAG )&#x20;

```
docker image list
REPOSITORY TAG IMAGE ID CREATED SIZE
httpd alpine 52862a02e4e9 2 weeks ago 112MB
httpd latest c2aa7e16edd8 2 weeks ago 165MB
ubuntu latest 549b9b86cb8d 4 weeks ago 64.2MB
docker image tag httpd:alpine httpd:customv1
docker image list
REPOSITORY TAG IMAGE ID CREATED SIZE
httpd alpine 52862a02e4e9 2 weeks ago 112MB
httpd customv1 52862a02e4e9 2 weeks ago 112MB
httpd latest c2aa7e16edd8 2 weeks ago 165MB
ubuntu latest 549b9b86cb8d 4 weeks ago 64.2MB
```

\----------------------------------------------

list all objects number you have with it's size :&#x20;

```
docker system df
TYPE TOTAL ACTIVE SIZE RECLAIMABLE
Images 3 0 341.9MB 341.9MB (100%)
Containers 0 0 0B 0B
Local Volumes 0 0 0B 0B
Build Cache 0 0 0B 0
```

\-------------------------------------------------

remove image (if there are a multiple tags of the same image and you only remove one of them the image will not deleted before removing every images )

```
docker image rm httpd:[tag]
Untagged: httpd:customv1
docker image rm httpd:customv1
Untagged: httpd:customv1
Note: An image cannot be removed if a container is dependent on it. All
containers must be removed and deleted first.
docker image rm httpd:alpine
untagged: httpd:alpine
deleted: sha256:549b9b86cb8d75a2b668c21c50ee092716d070f129fd1493f95ab7e43767eab8
deleted: sha256:7c52cdc1e32d67e3d5d9f83c95ebe18a58857e68bb6985b0381ebdcec73ff303
deleted: sha256:a3c2e83788e20188bb7d720f36ebeef2f111c7b939f1b19aa1b4756791beece0
deleted: sha256:61199b56f34827cbab596c63fd6e0ac0c448faa7e026e330994818190852d479
deleted: sha256:2dc9f76fb25b31e0ae9d36adce713364c682ba0d2fa70756486e5cedfaf40012
```

\--------------------------------------------------

&#x20;Image Prune: removing all unused image

```
docker image prune -a
WARNING! This will remove all images without at least one container associated to them.
Are you sure you want to continue? [y/N] y
Deleted Images:
untagged: ubuntu:latest
untagged: ubuntu@sha256:250cc6f3f3ffc5cdaa9d8f4946ac79821aafb4d3afc93928f0de9336eba21aa4
deleted: sha256:549b9b86cb8d75a2b668c21c50ee092716d070f129fd1493f95ab7e43767eab8
deleted: sha256:7c52cdc1e32d67e3d5d9f83c95ebe18a58857e68bb6985b0381ebdcec73ff303
deleted: sha256:a3c2e83788e20188bb7d720f36ebeef2f111c7b939f1b19aa1b4756791beece0
deleted: sha256:61199b56f34827cbab596c63fd6e0ac0c448faa7e026e330994818190852d479
deleted: sha256:2dc9f76fb25b31e0ae9d36adce713364c682ba0d2fa70756486e5cedfaf40012
untagged: httpd:latest
untagged: httpd@sha256:769018135ba22d3a7a2b91cb89b8de711562cdf51ad6621b2b9b13e95f3798de
deleted: sha256:c2aa7e16edd855da8827aa0ccf976d1d50f0827c08622c16e0750aa1591717e5
deleted: sha256:9fa170034369c33a4c541b38ba11c63c317f308799a46e55da9bea5f9c378643
deleted: sha256:9a41b3deb4609bec368902692dec63e858e6cd85a1312ee1931d421f51b2a07c
deleted: sha256:ed10451b31dfca751aa8d3e4264cb08ead23d4f2b661324eca5ec72b0e7c59fa
deleted: sha256:06020df9067f8f2547f53867de8e489fed315d964c9f17990c3e5e6a29838d98
deleted: sha256:556c5fb0d91b726083a8ce42e2faaed99f11bc68d3f70e2c7bbce87e7e0b3e10
Total reclaimed space: 229.4MB
```

\------------------------------------------------------------

view all layers and commands used to create image&#x20;

```
docker image history ubuntu
IMAGE CREATED CREATED BY SIZE
COMMENT
549b9b86cb8d 4 weeks ago /bin/sh -c #(nop) CMD ["/bin/bash"] 0B
<missing> 4 weeks ago /bin/sh -c mkdir -p /run/systemd && echo 'do… 7B
<missing> 4 weeks ago /bin/sh -c set -xe && echo '#!/bin/sh' > /… 745B
<missing> 4 weeks ago /bin/sh -c [ -z "$(apt-get indextargets)" ] 987kB
<missing> 4 weeks ago /bin/sh -c #(nop) ADD file:53f100793e6c0adfc… 63.2MB
```

inspect image&#x20;

```
docker image inspect httpd 
```

inspect with json grep&#x20;

```
docker image inspect httpd -f '{{.Os}}'
linux
```

\-------------------------------------------------------------

copy image from current host (image) as to another that dont have internet&#x20;

```
on your host : 
docker image save alpine:latest -o alpine.tar
on the other host after moving alpine.tar to it
docker image load -i alpine.tar
beee9f30bc1f: Loading layer [===============>] 5.862MB/5.862MB
Loaded image: alpine:late
```

copy image from current host (container) as to another that dont have internet&#x20;

```
on your host
docker export <container-name> > testcontainer.tar
on the other host after moving testcontainer.tar to it
docker image import testcontainer.tar newimage:latest
sha256:8090b7da236bb21aa2e52e6e04dff4b7103753e4046e15457a3daf6dfa723a12
```
