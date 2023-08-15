# Docker commands

&#x20;Setup:

&#x20;show docker information (how many images,containers)

```
 sudo docker system info | more
```

&#x20;docker service check and start

```
sudo systemctl status docker
sudo systemctl start docker
sudo systemctl stop docker
```

(docker service configuration)docker manually start and debug for troubleshoot

```
dockerd
dockerd --debug
```

## &#x20;docker command syntax :&#x20;

docker \[docker object] \[sub command] \[options] \[arguments/commands ]

baisc example :&#x20;

* docker image ls
* docker network ls
* docker container ls
* docker volume ls



```
new syntax :
docker container run -it ubuntu 
docker image build .
docker container attach ubuntu
docker container kill ubuntu
old syntax (still works):
docker run -it ubuntu
docker build .
docker attach ubuntu
docker kill ubuntu
```

## &#x20;Container Create - Create a new container from image and check its files :

```
docker container create httpd
Unable to find image 'httpd:latest' locally #ملاحظة :not finding the container localy pull it from docker hub
latest: Pulling from library/httpd
8ec398bc0356: Pull complete
354e6904d655: Pull complete
36412f6b2f6e: Pull complete
Digest:
sha256:769018135ba22d3a7a2b91cb89b8de711562cdf51ad6621b2b9b13e95f3798de
Status: Downloaded newer image for httpd:latest
36a391532e10d45f772f2c9430c2cc38dad4b441aa7a1c44d459f6fa3d78c6b6#ملاحظة:unique container ID
ls -lrt /var/lib/docker/containers/
36a391532e10d45f772f2c9430c2cc38dad4b441aa7a1c44d459f6fa3d78c6b6
ls /var/lib/docker/
builder containers network plugins swarm trust
buildkit image overlay2 runtimes tmp volumes
ls -lrt /var/lib/docker/containers/36a391532e10*
Checkpoint hostconfig.json config.v2.json
```

## &#x20;Container ls - List the details for container:

```
docker container ls # list runnig containers only
CONTAINER ID IMAGE COMMAND CREATED STATUS PORTS NAMES
docker container ls -a # list runnig containers and not running
CONTAINER ID IMAGE COMMAND CREATED STATUS PORTS NAMES
36a391532e10 httpd "httpd-foreground" 2 minutes ago Created charming_wiles
docker container ls -l # list the last created container only
CONTAINER ID IMAGE COMMAND CREATED STATUS PORTS NAMES
36a391532e10 httpd "httpd-foreground" 2 minutes ago Created charming_wiles
docker container ls -q # list the sort id of runnig containers only
docker container ls -aq# list the sort id of runnig containers and not running
36a391532e10
```

\------------------------------------------------------------------------------------------

## &#x20;Run existing container :&#x20;

&#x20;

```
docker container start 36a391532e10 #<---container ID
36a391532e10
```

\------------------------------------------------------------------------------------------

## Run – Create and Start a container in the same time :&#x20;

```
docker container run ubuntu
Unable to find image 'httpd:latest' locally
latest: Pulling from library/httpd
8ec398bc0356: Pull complete
354e6904d655: Pull complete
36412f6b2f6e: Pull complete
Digest: sha256:769018135ba22d3a7a2b91cb89b8de711562cdf51ad6621b2b9b13e95f3798de
Status: Downloaded newer image for httpd:latest
36a391532e10d45f772f2c9430c2cc38dad4b441aa7a1c44d459f6fa3d78c6b6
```

\-----------------------------------------------------------------------------------------

## &#x20;CONTAINER NAME :&#x20;



```
naming when creat the container :
docker container run --name=webapp ubuntu 
rename existing container : 
docker container rename [old name] [new name]
```

\----------------------------------------------------------------------------------------------

## &#x20;Run the container in the background(Detached Mode)

```
docker container run –d httpd
11cbd7fe7e65a9da453e159ed0fe163592dccc
#to reattahce the container from background (foregrond)
docker container attach [first uniqu char from id here : 11cb]
--------------------------------------------------
another example 
-->
docker container run -itd ubuntu
```

\----------------------------------------------------------------------------------------------

## Interacting with a Running Container Commands&#x20;



```
docker container run -it ubuntu
root@b71f15d33b60: [PRESS CTRL+p+q] #foreground shell ---> background
docker container ls -l
CONTAINER ID IMAGE COMMAND CREATED STATUS PORTS NAMES
b71f15d33b60 ubuntu "/bin/bash" 3 minutes ago Up 3#لسا شغالة minutes magical_babbag
--------------------------
run command in the container when its  running in the background :
docker container exec b71f15d33b60 hostname
b71f15d33b60
------------------------
background ---> foreground 
#DENGEROUS WAY
docker container attach b71f15d #re-enter to the orginal process so if you type exit 
you will kill the main shell and the container will DI
----
OR
----
docker exec -it b71f15d33b60 /bin/bash #enter as new process so if you type exit 
you will not kill the main shell and the container will still ACTIVE
root@b71f15d33b60:/#
```

\-------------------------------------------------------------------------------------------------

## &#x20;Inspecting a Container

```
docker container inspect webapp #view metadata/informations about container
-------------------------------------
docker container stats # resources utilaization/use by the containers
CONTAINER ID NAME CPU % MEM USAGE / LIMIT MEM % NET I/O BLOCK PIDS
59aa5eacd88c webapp 50.00% 400KiB / 989.4MiB 0.04% 656B / 0B 0B /
0a00b5535783d epic_leavitt 0.00% 404KiB / 989.4MiB 0.04% 656B / 0B 0B / 
0616f80b0f026 elegant_cohen 0.00% 404KiB / 989.4MiB 0.04% 656B / 0B 0B / 
036a391532e10 charming_wiles 0.01% 8.363MiB / 989.4MiB 0.85% 656B / 0B 0B / 0
----------------------------------------
docker container top webapp # list the process of the docker host/container
UID PID PPID C STIME TTY TIME CMD
root 17001 16985 0 13:23 ? 00:00:00 stress
-------------------------------------------
docker container logs webapp #view the logs 
AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 172.17.0.6. Set the 'ServerName'
directive globally to suppress this message
AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 172.17.0.6. Set the 'ServerName'
directive globally to suppress this message
[Tue Jan 14 13:38:15.699310 2020] [mpm_event:notice] [pid 1:tid 140610463122560] AH00489: Apache/2.4.41 (Unix) configured --
resuming normal operations
[Tue Jan 14 13:38:15.699520 2020] [core:notice] [pid 1:tid 140610463122560] AH00094: Command line: 'httpd -D FOREGROUND'
---------------------------------------------
docker container logs -f webapp # live stream for the logs
----------------------------------------------
docker system events --since 60m # view all the events in your containers :start,run,create,etc...
2020-01-14T18:30:30.423389441Z network connect d349c5984e7eebab74db57b8529df40e11a140f98a6b5e3ee1807aaeafa0e684
(container=68649c8b359f89db7a3866ee0ebcc7261c0cb9697f3a624cd314c8f4f652f84b, name=bridge, type=bridge)
2020-01-14T18:30:30.721669156Z container start 68649c8b359f89db7a3866ee0ebcc7261c0cb9697f3a624cd314c8f4f652f84b (image=ubuntu, name=casethree)2020-01-14T18:40:46.779320656Z network connect d349c5984e7eebab74db57b8529df40e11a140f98a6b5e3ee1807aaeafa0e684
(container=71c90a19b9876c9ce2eb9d035355a062fdaceed4a714b61ddf0612651d47d3e2, name=bridge, type=bridge)
2020-01-14T18:40:47.076482525Z container start 71c90a19b9876c9ce2eb9d035355a062fdaceed4a714b61ddf0612651d47d3e2 (image=ubuntu, name=webapp)
```

\-------------------------------------------------------

## &#x20;Linux Process signals :&#x20;

&#x20;

```
Linux Signals
if the process name is : httpd
kill –SIGSTOP 11663 $(pgrep httpd) # pause the process 
kill –SIGCONT $(pgrep httpd) #resume the process after pause
kill –SIGTERM $(pgrep httpd) # send warning to the process that i want to stop you but the process sometimes don't respone
kill –SIGKILL $(pgrep httpd)# kill the process now
kill –9 $(pgrep httpd) # all signals above has a number you can send the signal using its number
```

\---------------------------------------------------------------------------------------------------

## &#x20;Docker Container Signals&#x20;

```
docker container run --name web httpd
---------------------------------------------
freezer cgroup : is used to pause and  unpause container insted of SIGSTOP,STIGCONT 
using this way the processes within the container
are unaware of what's happening to them and
that they won't be able to catch any of these
signals so it would work as expected.
Apart from these commands, we can also
send specific signals to the process within the
container using the docker container kill
command.
1-docker container pause web #pause the running container
2-docker container unpause web #resume the running container after pause
-----------------------------------------------------------
docker container stop web # first sends SIGTERM and after a period of time if the container does't respone send SIGKILL 
docker container kill --signal=9 web  # all signals above has a number you can send the signal using its number
```

\------------------------------------------------------------------------------------------

## Removing container : first stop the container then remove it

```
docker container stop web
web
ls -lrt /var/lib/docker/containers/
36a391532e10d45f772f2c9430c2cc38dad4b441aa7a1c44d459f6fa3d78c6b6
docker container rm web
web
ls -lrt /var/lib/docker/containers/
[Empty]
```

\------------------------------------------------------------------------------------------

## Removing All container : first stop All the containers then remove it

```
docker container stop $(docker container ls -q)
59aa5eacd88c
a00b5535783d
616f80b0f026
36a391532e10
docker container rm $(docker container ls -aq)
59aa5eacd88c
a00b5535783d
616f80b0f026
36a391532e10
```

<pre class="language-html"><code class="lang-html"><strong>
</strong><strong>docker container stop $(docker container ls -q)
</strong><strong>59aa5eacd88c
</strong>a00b5535783d
616f80b0f026
36a391532e10
docker container prune
WARNING! This will remove all stopped containers.
Are you sure you want to continue? [y/N] y
Deleted Containers:
59aa5eacd88c
a00b5535783d
616f80b0f026
36a391532e10
Total reclaimed space: 1223423
</code></pre>

## &#x20;but settings when create container to Remove it after finishing  it's work (Remove Flag)

```
docker container run --rm ubuntu expr 4 + 5
9
```

\-------------------------------------------------------------------------

## Container Hostname(by default it will be the short container ID)

```
docker container run -it --name=webapp ubuntu
root@3484d738:/# hostname
3484d738
-------------------------------------------
docker container run -it --name=webapp --hostname=mohannad ubuntu
root@mohannad :/# hostname
mohannad
```

\------------------------------------------------------------------------

## &#x20;Restart Policies : (you can find more informations in Docker Engine Page  )

```
docker container run --restart=no ubuntu # default
docker container run --restart=on-failure ubuntu
docker container run --restart=always ubuntu
docker container run --restart=unless-stopped ubuntu
```

\--------------------------------------------------------------------------

## Live Restore

it's a configuration that's make your containers don't stops and still running when your Docker Daemon stopped/Crash&#x20;

```
gedit/etc/docker/daemon.json
{
"debug": true,
"hosts": ["tcp://192.168.1.10:2376"],
"live-restore": true #add this to your file
}
systemctl reload docker
```
