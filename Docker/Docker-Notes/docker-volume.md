# Docker Volume

Docker volume :  a drive you can mount it to your running container <mark style="color:red;">to write data on it and read data from it</mark>&#x20;

&#x20;after mounting a drive every data saved on the mounted directory will saved also on the drive on your host&#x20;

&#x20;you can find the volume on your host&#x20;

```
 volume inspect ---> "Mountpoint": "/var/lib/docker/volumes/testvol/_data"
```

commands :&#x20;

list all volumes

```
escanor@escanor-virtual-machine:~/Desktop$ docker volume ls
DRIVER    VOLUME NAME
```

create a volume

```
escanor@escanor-virtual-machine:~/Desktop$ docker volume create testvol
```

mount a volume to container :&#x20;

```
escanor@escanor-virtual-machine:~/Desktop$ docker container run -itd -v testvolname:/dirDest ubuntu
968fc9f1574613a98a9fe4038b24d96deb852b7c530fc723e455fc8620f8c2b3
```

OR

```
escanor@escanor-virtual-machine:~/Desktop$ docker container run -itd --mount source=testvol,destination=/mohannad ubuntu
0251e23a056226ada060806675d47841e53b771f1aa51eed6942bdaa43d64f0b
```

&#x20;check the mounted volumes in the container :&#x20;

```
escanor@escanor-virtual-machine:~/Desktop$ docker exec -it 968f /bin/bash
root@968fc9f15746:/# df -h | grep -i /mohannad
/dev/sda3       118G   23G   89G  21% /mohannad
```

&#x20;inspect volume :&#x20;

```
escanor@escanor-virtual-machine:~/Desktop$ docker volume inspect testvol
[
    {
        "CreatedAt": "2023-08-20T09:13:22+03:00",
        "Driver": "local",
        "Labels": null,
        "Mountpoint": "/var/lib/docker/volumes/testvol/_data",
        "Name": "testvol",
        "Options": null,
        "Scope": "local"
    }
]
```

&#x20;     delete volume (should be not mounted):&#x20;

```
escanor@escanor-virtual-machine:~/Desktop$ docker volume rm testvol
Error response from daemon: remove testvol: volume is in use - [0251e23a056226ada060806675d47841e53b771f1aa51eed6942bdaa43d64f0b]
```

&#x20; Delete all un-used volumes

```
escanor@escanor-virtual-machine:~/Desktop$ docker volume
```

&#x20; mount volume as read-only (RW flag on the container inspect = false)

```
escanor@escanor-virtual-machine:~/Desktop$ docker container run -itd --mount source=testvol,destination=/mohannad,readonly ubuntu
795a3c41423403ae71969fdf33eaa218befdd2e65ebb37d9aedb671d9a5bef87
```

bind mount adding file/directory to container (not a volume)

```
escanor@escanor-virtual-machine:~/Desktop$ docker container run -itd --mount type=bind,source=anyDirectory,destination=/mohannad ubuntu
```

.
