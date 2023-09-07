# commands

install Jenkins :&#x20;

```
escanor@escanor-virtual-machine:~/Desktop/JenkinsCourse/First/go-webapp-sample$ sudo apt install openjdk-11-jdk
escanor@escanor-virtual-machine:~/Desktop/JenkinsCourse/First/go-webapp-sample$ sudo apt install maven
escanor@escanor-virtual-machine:~/Desktop/JenkinsCourse/First/go-webapp-sample$ curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins
escanor@escanor-virtual-machine:~/Desktop/JenkinsCourse/First/go-webapp-sample$ systemctl status jenkins.service 
● jenkins.service - Jenkins Continuous Integration Server
     Loaded: loaded (/lib/systemd/system/jenkins.service; enabled; vendor preset: enabled)
     Active: active (running) since Tue 2023-09-05 14:50:27 +03; 42s ago
   Main PID: 9632 (java)
      Tasks: 50 (limit: 11607)
     Memory: 2.4G
        CPU: 1min 45.200s
     CGroup: /system.slice/jenkins.service
             └─9632 /usr/bin/java -Djava.awt.headless=true -jar /usr/share/java/jenkins.war --webroot=/var/cache/jenkins/war --http>

أيلول 05 14:49:51 escanor-virtual-machine jenkins[9632]: a1c198147b514d5093e85dcca3156473
أيلول 05 14:49:51 escanor-virtual-machine jenkins[9632]: This may also be found at: /var/lib/jenkins/secrets/initialAdminPassword
أيلول 05 14:49:51 escanor-virtual-machine jenkins[9632]: *************************************************************
أيلول 05 14:49:51 escanor-virtual-machine jenkins[9632]: *************************************************************
أيلول 05 14:49:51 escanor-virtual-machine jenkins[9632]: *************************************************************
أيلول 05 14:50:27 escanor-virtual-machine jenkins[9632]: 2023-09-05 11:50:27.796+0000 [id=30]        INFO        jenkins.InitReacto>
أيلول 05 14:50:27 escanor-virtual-machine jenkins[9632]: 2023-09-05 11:50:27.815+0000 [id=23]        INFO        hudson.lifecycle.L>
أيلول 05 14:50:27 escanor-virtual-machine systemd[1]: Started Jenkins Continuous Integration Server.
أيلول 05 14:50:28 escanor-virtual-machine jenkins[9632]: 2023-09-05 11:50:28.788+0000 [id=51]        INFO        h.m.DownloadServic>
أيلول 05 14:50:28 escanor-virtual-machine jenkins[9632]: 2023-09-05 11:50:28.795+0000 [id=51]        INFO        hudson.util.Retrie>

```

allow the port 8080 on the firewall :&#x20;

```
escanor@escanor-virtual-machine:~/Desktop/JenkinsCourse/First/go-webapp-sample$ sudo ufw allow 8080
Rule added
Rule added (v6)
escanor@escanor-virtual-machine:~/Desktop/JenkinsCourse/First/go-webapp-sample$ sudo ufw status
Status: active

To                         Action      From
--                         ------      ----
Nginx HTTPS                ALLOW       Anywhere                  
Nginx Full                 ALLOW       Anywhere                  
8080                       ALLOW       Anywhere                  
Nginx HTTPS (v6)           ALLOW       Anywhere (v6)             
Nginx Full (v6)            ALLOW       Anywhere (v6)             
8080 (v6)                  ALLOW       Anywhere (v6)             
```

```
user : mohannad 
password : Usual pass
full name : mohannad alamayreh
```

using jenkins cli (after get the token from jenkins gui)

```
java -jar jenkins-cli.jar -s http://localhost:8080/ -auth mohannad:11b52877db9d8c933d1592cc609bc9a8bc
```

Finding plugins. `Dashboard --> Manage Jenkins --> Manage Plugins`.

You might need to restart Jenkins service after installing some plugins or after making some configuration changes etc. In such case please make sure Jenkins service is back up before you submit your solution.

you can do the restart from the GUI or From CLI :&#x20;

```
service jenkins restart
or 
systemctl restart jenkins
```

Plugins are the primary means of enhancing the functionality of a Jenkins environment to suit organization or user specific needs.

Create User in Jenkins Gui :&#x20;

`Manage Jenkins` -->`Users` --> `Create User`

`-----------------------------------------------------------------------------`

### Enable Role-based Authorization Strategy to assign permission to Users&#x20;

Plugin installation steps:\
\
\
1: Go to `Manage Jenkins`, then click on `Plugins` tab.\
\
2: Click on `Available` section and search for `Role-based Authorization Strategy` plugin.\
\
3: Then mark the box `check` and click on `Install without restart` button.\
\
4: After that click on `Restart Jenkins when installation is complete and no jobs are running`.\
\
\
Steps to enable `Role-Based Strategy` authorization in Jenkins security settings:\
\
\
1: Go to `Manage Jenkins`, then click on `Security` tab.\
\
2: Then search for `Role-Based Strategy` under `Authorization` section and check the box.\
\
3: Click on the `Save` button at the bottom of the page.

<mark style="color:blue;">After that you can assign roles to users by</mark> <mark style="color:blue;"></mark><mark style="color:blue;">`Manage Jenkins`</mark><mark style="color:blue;">, then click on</mark> <mark style="color:blue;"></mark><mark style="color:blue;">`Manage and Assign Roles`</mark> <mark style="color:blue;"></mark><mark style="color:blue;">tab.</mark>

<mark style="color:red;">from there you can Create Roles , then assign the roles to the Users.</mark>

&#x20;\------------------------------------------------------------------------------------

Create a `List View`

1: Click on the `+` button next to `All`in Jenkins dashboard.\
\
2: Enter the name of the view in `Name` section and check `List View` box, then click `Create`.\
\
3: Again on the new window click on `ok` button.

\--------------------------------------------------------------------------------------

Change the default number of `executors` in Jenkins :&#x20;

1: Go to `Manage Jenkins` and click on `System` under `System Configuration`.\
\
2: Then input value `4` in the box under `# of executors`.\
\
3: Click on `Save` button on bottom of the window.&#x20;

\--------------------------------------------------------------------------------------

Add `Maven` installations in Jenkins :&#x20;

1: Go to `Manage Jenkins` and click on `Tools` under `System Configuration`.\
\
2: Then Click on `Add Maven` button under `Maven` section.\
\
3: By default the Installer is set to `Install from Apache`, so you don't need to change that.\
\
4: Now add a name `dev_maven` and select the version `3.8.4` from the drop down menu.\
\
5: Click on the `Save` button on bottom of the page.

\---------------------------------------------------------------------

Change SCM checkout retry count Jenkins : \
\
1: Go to `Manage Jenkins` and click on `System` under `System Configuration`.\
\
2: Set `SCM checkout retry count` value to `2`.\
\
3: Click on `save` button on bottom of the page.

\----------------------------------------------------------------------

