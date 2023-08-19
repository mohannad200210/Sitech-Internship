# Docker Security

## Secure Docker Server :&#x20;

what could happen if a bad hacker get access to your docker daemon :&#x20;

• Delete existing containers hosting applications&#x20;

• Delete volumes storing data

• Run containers to run their applications (bit coin mining)&#x20;

• Gain root access to the host system by running <mark style="color:red;">a privileged container (</mark><mark style="color:blue;">`docker run --privileged -it <image_name>`</mark><mark style="color:red;">)</mark>

• Target the other systems in the network and network itself



but because Docker Daemon is located in your local host so the first level of secure your host is secure your local machine by :&#x20;

* Disable Password based authentication&#x20;
* &#x20;Enable SSH key based authentication&#x20;
* &#x20;Determine users who needs access to the serve



`/var/run/docker.sock :(localiy communication between Docker CLI and Docker DAEMON):`This socket file is a communication endpoint that allows local processes to interact with the Docker daemon. The Docker CLI communicates with the daemon through this socket to issue commands and manage containers, networks, images, and other Docker-related resources.



this mean docker is listen locally and remotely :

`gedit /etc/docker/docker.json --->"hosts": ["tcp://192.6.80.6:2375", "unix:///var/run/docker.sock"]`



### configure external/remote access to your docker Daemon : &#x20;

docker remotely access with encryption vs docker remotely access with encryption and Authentication :&#x20;

<figure><img src=".gitbook/assets/docker remotly.png" alt=""><figcaption><p>docker remotely access with encryption vs docker remotely access with encryption and Authentication </p></figcaption></figure>

&#x20;what should you do in the remote machine to access docker (docker remotely access with encryption only) :&#x20;

```
export DOCKER_TLS=true
export DOCKER_HOST=“tcp://192.168.1.10:2376”
docker ps 
```

what should you do in the remote machine to access docker (docker remotely access with encryption and Authentication) :&#x20;

```
export DOCKER_TLS=true
export DOCKER_HOST=“tcp://192.168.1.10:2376”
docker tlscert=<> --tlskey=<> --tlscacert=<> ps
```

### VM vs Docker :&#x20;

VM : totally isolated from the host system&#x20;

Docker : not isolated from your host only namespace give some isolating for somethings like : pid , network

Docker shares the same kernal with your host device.

### Namespaces(isolation):

PID namespaces : first pid in docker ==1 ----> the same pid is exist in your host with anthor random pid&#x20;

\--------------------------------

the container have a root users and other users&#x20;

if you run a process as root user in the container the same process will be in your host as root also&#x20;

so if you dont want this to happen you have to specify the user in the container before run it&#x20;

```
docker container run --user=1000 ubuntu sleep 3600
```

\----------------------------------------------------------------------

### CGROUPS :&#x20;

&#x20;Cgroups or control groups, are a Linux feature that allows to allocate resources such as CPU, memory, network bandwidth, or block I/O among different processes within our host. Docker uses groups to share or limit resources among different containers. In the upcoming lectures, we will discuss how to limit resource usage on containers using groups.

\---------------------------------------------------------------------

## Resources Limits for the containers CPU and MEMORY

بتقدر تحط حدود لاستعمال المعالج والرام من قبل بروسيس الدوكر كونتينر

If a container consumes more memory than its limit, then it will be killed with an out of memory exception.&#x20;

If a container tries to use more CPU than assigned, the container is not killed, it's just throttled(خنق).

Each container gets a CPU share of 1024 assigned by default.

if the --memory-swap is set to -1 the container is allowed to use unlimited swap

```
MEM reserve:
escanor@escanor-virtual-machine:~/Desktop$ docker run -itd --memory=200m --memory-swap=-1 ubuntu
d986eebb46842707cc6b8789a2cc42917d9e28d5a6f4eb276bc3d6341c8a39d1
escanor@escanor-virtual-machine:~/Desktop$ docker inspect d98 | grep -i memory
            "Memory": 209715200,
            "MemoryReservation": 0,
            "MemorySwap":-1,
            "MemorySwappiness": null,
            
# min mem=100 max mem=200 unlimted memswap:
escanor@escanor-virtual-machine:~/Desktop$ docker run -itd --memory=200m --memory-swap=-1 --memory-reservation=100m ubuntu
d986eebb46842707cc6b8789a2cc42917d9e28d5a6f4eb276bc3d6341c8a39d1
escanor@escanor-virtual-machine:~/Desktop$ docker inspect d98 | grep -i memory
            "Memory": 209715200,
            "MemoryReservation": 209715200,
            "MemorySwap":-1,
            "MemorySwappiness": null,
------------------------------------------------
CPU reserve :
# number of cpu resources/processing units in your host
escanor@escanor-virtual-machine:~/Desktop$ nproc
4
# only use 2 processing units out of 4
escanor@escanor-virtual-machine:~/Desktop$ docker run -itd --cpus=2 ubuntu
1055be624d7af96e39fb73fca07f6e4921567ff8708f06bdba60913d6332f7c8
escanor@escanor-virtual-machine:~/Desktop$ docker inspect 1055 | grep -i cpu
            "CpuShares": 0,
            "NanoCpus": 2000000000,
            "CpuPeriod": 0,
            "CpuQuota": 0,
            "CpuRealtimePeriod": 0,
            "CpuRealtimeRuntime": 0,
            "CpusetCpus": "",
            "CpusetMems": "",
            "CpuCount": 0,
            "CpuPercent": 0,
            
escanor@escanor-virtual-machine:~/Desktop$ docker run -itd --cpus=2 ubuntu
1055be624d7af96e39fb73fca07f6e4921567ff8708f06bdba60913d6332f7c8
escanor@escanor-virtual-machine:~/Desktop$ docker inspect d98 | grep -i cpu
            "CpuShares": 0,
            "NanoCpus": 0,
            "CpuPeriod": 0,
            "CpuQuota": 0,
            "CpuRealtimePeriod": 0,
            "CpuRealtimeRuntime": 0,
            "CpusetCpus": "",
            "CpusetMems": "",
            "CpuCount": 0,
            "CpuPercent": 0,
escanor@escanor-virtual-machine:~/Desktop$ docker inspect 1055 | grep -i cpu
            "CpuShares": 0,
            "NanoCpus": 2000000000,
            "CpuPeriod": 0,
            "CpuQuota": 0,
            "CpuRealtimePeriod": 0,
            "CpuRealtimeRuntime": 0,
            "CpusetCpus": "",
            "CpusetMems": "",
            "CpuCount": 0,
            "CpuPercent": 0,
#have the half time of cpu share (Each container gets a CPU share of 1024 assigned by default)
escanor@escanor-virtual-machine:~/Desktop$ docker container run --cpu-shares=512 webapp4
#cpu access only locked for the third process
escanor@escanor-virtual-machine:~/Desktop$ docker container run --cpuset-cpus=2 webapp3
#cpu access only locked for the first and second process
escanor@escanor-virtual-machine:~/Desktop$ docker container run --cpuset-cpus=0-1 webapp1



```

\
\--------------------------------------------------------------------------------------------------

### Kernal capabilities(قدرات)

&#x20;: a linux feature that prevents a process within the container to access raw sockets

for every user there is a set of capabilities&#x20;

you can see the linux system capabilities here :&#x20;

cat /usr/include/linux/capability.h

&#x20;By default, Docker runs a container with a limited set of capabilities, and so for example when the processes running within the container do not have the privileges to say reboot the host ..

to add capabilities/privileges to container:

```
docker run --cap-add MAC_ADMIN ubuntu
```

to remove capabilities/privileges to container:

```
docker run --cap-drop KILL ubuntu
```

<mark style="color:red;">to get full privileges access for the container (DENGEROUS)</mark>&#x20;

```
docker run --privileged ubuntu
```
