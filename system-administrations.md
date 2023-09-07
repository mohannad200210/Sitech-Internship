# System administrations

* Backup&#x20;
* Restore&#x20;
* Monitor
* Scale
* Mange

### &#x20;Creating a Backup :&#x20;

Under location $JENKINS\_HOME Jenkins store its data primarily. and $JENKINS\_HOME `directory` is most important to backup, since it contains all jobs, configuration, build history, plugins etc.

&#x20;Various schemes can be used to create backups.

• Filesystem snapshots&#x20;

• Plugins for backup&#x20;

• Write a shell script that backs up the Jenkins instance

you can Download (<mark style="color:red;">thinbackup</mark>) plugin to do the backup

\-----------------------

backup steps :&#x20;

Create the backup directory first from command line:

```sh
sudo mkdir /var/lib/jenkins/jenkins_backup
sudo chown -R jenkins /var/lib/jenkins/jenkins_backup
```

\
Login into the Jenkins and follow the below given steps:\
1\. Go to `Manage Jenkins`.\
\
2\. Click on `ThinBackup`.\
\
3\. Go to `Settings` and enter `/var/lib/jenkins/jenkins_backup` as the `Backup directory`, tick `Backup plugins archives` check box and save the changes.\
\
4\. Click on `Backup Now`.

\--------------------------

### Restore :&#x20;

if you want to restore a backup you can use thinbackup plugin

Restore backup steps :&#x20;

1\. Go to `Manage Jenkins`.\
2\. Click on `ThinBackup`.\
3\. Click on `Restore`.\
4\. Select the latest backup available from the list, select `Restore plugins` and then click `Restore` (you need not to select any other options).\
5\. Restart Jenkins service.

```sh
service jenkins restart
```

\---------------------------------

### Monitoring Jenkins :&#x20;

1- install Prometheus plugin

1\. Go to `Manage Jenkins`.\
2\. Click on `Plugins`.\
3\. Under `Available`, search for `Prometheus metrics` plugin.\
4\. Select it and install.\
5\. Once installed click on `Restart Jenkins when installation is complete and no jobs are running`.



