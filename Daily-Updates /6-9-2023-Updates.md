## Yesterday i started the Jenkins course and You can see What i learned and the POC is here :


**install jenkins :** 
- install java as prerequisite
```
escanor@escanor-virtual-machine:~/Desktop/JenkinsCourse/First/go-webapp-sample$ sudo apt install openjdk-11-jdk
```
- install maven as prerequisite
```
escanor@escanor-virtual-machine:~/Desktop/JenkinsCourse/First/go-webapp-sample$ sudo apt install maven
```
- install jenkins
```
escanor@escanor-virtual-machine:~/Desktop/JenkinsCourse/First/go-webapp-sample$ curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins
```
- Start jenkins service
```
escanor@escanor-virtual-machine:~/Desktop/JenkinsCourse/First/go-webapp-sample$ systemctl start jenkins.service 
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
- Enable port 8080 on the firewall
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

**Authentication in Jenkins CLI :** 
- generate API token from Jenkins API :
![image](https://github.com/mohannad200210/Sitech-Internship/assets/95110750/fe4f468a-949d-40e2-824d-045246a30c77)

- Download jenkins-cli.jar to connect to Jenkins using it by the API token we generate 
```
escanor@escanor-virtual-machine:~/Desktop$ wet http://localhost:8080/jnlpJars/jenkins-cli.jar
```
- now let's try if the CLI works
```
escanor@escanor-virtual-machine:~/Desktop$ java -jar jenkins-cli.jar -s http://localhost:8080 -auth mohannad:11253e102d5adaf871253e55c8ba9ef49c -webSocket list-jobs
test-1
test-2 
```

**Deal with Jenkins plugins using CLI : **
- list all installed plugins
```
escanor@escanor-virtual-machine:~/Desktop$ java -jar jenkins-cli.jar -s http://localhost:8080 -auth mohannad:11253e102d5adaf871253e55c8ba9ef49c list-plugins
pipeline-model-extensions          Pipeline: Declarative Extension Points API  2.2144.v077a_d1928a_40
git-client                         Git client plugin                           4.4.0
pipeline-groovy-lib                Pipeline: Groovy Libraries                  685.v8ee9ed91d574
mina-sshd-api-common               Mina SSHD API :: Common                     2.10.0-69.v28e3e36d18eb_
caffeine-api                       Caffeine API Plugin                         3.1.8-133.v17b_1ff2e0599
pipeline-milestone-step            Pipeline: Milestone Step                    111.v449306f708b_7
scm-api                            SCM API Plugin                              676.v886669a_199a_a_
email-ext                          Email Extension Plugin                      2.100
bootstrap5-api                     Bootstrap 5 API Plugin                      5.3.0-1
github-branch-source               GitHub Branch Source Plugin                 1732.v3f1889a_c475b_
github                             GitHub plugin                               1.37.3
jquery3-api                        JQuery3 API Plugin                          3.7.0-1
github-api                         GitHub API Plugin                           1.314-431.v78d72a_3fe4c3
javax-activation-api               JavaBeans Activation Framework (JAF) API    1.2.0-6
mailer                             Mailer Plugin                               463.vedf8358e006b_
snakeyaml-api                      SnakeYAML API Plugin                        2.2-111.vc6598e30cc65
checks-api                         Checks API plugin                           2.0.0
workflow-basic-steps               Pipeline: Basic Steps                       1042.ve7b_140c4a_e0c
echarts-api                        ECharts API Plugin                          5.4.0-5
durable-task                       Durable Task Plugin                         523.va_a_22cf15d5e0
plain-credentials                  Plain Credentials Plugin                    143.v1b_df8b_d3b_e48
font-awesome-api                   Font Awesome API Plugin                     6.4.0-2
resource-disposer                  Resource Disposer Plugin                    0.23
javax-mail-api                     JavaMail API                                1.6.2-9
cloudbees-folder                   Folders Plugin                              6.848.ve3b_fd7839a_81
workflow-multibranch               Pipeline: Multibranch                       756.v891d88f2cd46
pipeline-graph-analysis            Pipeline Graph Analysis Plugin              202.va_d268e64deb_3
timestamper                        Timestamper                                 1.26
workflow-support                   Pipeline: Supporting APIs                   848.v5a_383b_d14921
jjwt-api                           Java JSON Web Token (JJWT) Plugin           0.11.5-77.v646c772fddb_0
credentials-binding                Credentials Binding Plugin                  631.v861c06d062b_4
ssh-credentials                    SSH Credentials Plugin                      308.ve4497b_ccd8f4
variant                            Variant Plugin                              60.v7290fc0eb_b_cd
workflow-api                       Pipeline: API                               1267.vd9b_a_ddd9eb_47
ionicons-api                       Ionicons API                                56.v1b_1c8c49374e
workflow-step-api                  Pipeline: Step API                          639.v6eca_cd8c04a_a_
apache-httpcomponents-client-4-api Apache HttpComponents Client 4.x API Plugin 4.5.14-208.v438351942757
workflow-durable-task-step         Pipeline: Nodes and Processes               1289.v4d3e7b_01546b_
jakarta-activation-api             Jakarta Activation API                      2.0.1-3
pipeline-model-api                 Pipeline: Model API                         2.2144.v077a_d1928a_40
pipeline-stage-tags-metadata       Pipeline: Stage Tags Metadata               2.2144.v077a_d1928a_40
pipeline-stage-step                Pipeline: Stage Step                        305.ve96d0205c1c6
okhttp-api                         OkHttp Plugin                               4.11.0-157.v6852a_a_fa_ec11
jaxb                               JAXB plugin                                 2.3.8-1
antisamy-markup-formatter          OWASP Markup Formatter Plugin               162.v0e6ec0fcfcf6
```
- install plugin :
```
escanor@escanor-virtual-machine:~/Desktop$ java -jar jenkins-cli.jar -s http://localhost:8080 -auth mohannad:11253e102d5adaf871253e55c8ba9ef49c install-plugin cloudbees-bitbucket-branch-source
Installing cloudbees-bitbucket-branch-source from update center
```
- after every change in plugins you have to restart jenkins :
```
escanor@escanor-virtual-machine:~/Desktop$ systemctl restart jenkins.service
```
- if you want to upgrade plugin you can use install-plugin also
```
escanor@escanor-virtual-machine:~/Desktop$ java -jar jenkins-cli.jar -s http://localhost:8080 -auth mohannad:11253e102d5adaf871253e55c8ba9ef49c install-plugin cloud-stats
```
- OR  you can update all installed plugins to their latest versions, use the install-plugin with the -u flag :
```
escanor@escanor-virtual-machine:~/Desktop$ java -jar jenkins-cli.jar -s http://localhost:8080 -auth mohannad:11253e102d5adaf871253e55c8ba9ef49c install-plugin -u
```
- To uninstall plugin :
```
escanor@escanor-virtual-machine:~/Desktop$ java -jar jenkins-cli.jar -s http://localhost:8080 -auth mohannad:11253e102d5adaf871253e55c8ba9ef49c uninstall-plugin cloud-stats
```
- To Disable plugin :
```
escanor@escanor-virtual-machine:~/Desktop$ java -jar jenkins-cli.jar -s http://localhost:8080 -auth mohannad:11253e102d5adaf871253e55c8ba9ef49c disable-plugin cloud-stats -restart -r
Disabling 'cloud-stats': DISABLED (Plugin 'cloud-stats' disabled)
```
- To Enable plugin :
```
escanor@escanor-virtual-machine:~/Desktop$ java -jar jenkins-cli.jar -s http://localhost:8080 -auth mohannad:11253e102d5adaf871253e55c8ba9ef49c enable-plugin cloud-stats
Enabling plugin `cloud-stats' (320.v96b_65297a_4b_b_)
Plugin `cloud-stats' was enabled.
```
