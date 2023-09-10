# tmp for daily update

Install `SSH Build Agents` Jenkins plugin.

Login into the Jenkins server and follow the below given steps:\
\
1\. Go to `Manage Jenkins`.\
2\. Click on `Plugins`.\
3\. Under `Available`, search for `SSH Build Agents` plugin.\
4\. Select it and install.\
5\. Once installed click on `Restart Jenkins when installation is complete and no jobs are running`.

\--------------------------------------

Manage Jenkins ---> security ---> configure Global security ---> auth --->Matrix-bassed security&#x20;

\--------------------------------------

Create a username and password based `credentials` in Jenkins as per details mentioned below:

Login into the Jenkins server and follow the below given steps:\
\
1\. Go to `Manage Jenkins`.\
2\. Click on `Credentials`.\
3\. Click on `(global)` under `Domains`.\
4\. From the option on the right side, click on `Add Credentials`.\
5\. Enter `bob` under `Username`.\
6\. Enter `caleston123` under `Password`.\
\
7\. Leave other options as it is and click on `OK`.

\---------------------------------------

Create a `Permanent Agent` &#x20;

Login into the Jenkins server and follow the below given steps:\
\
1\. Now go to `Manage Jenkins`.\
2\. Click on `Nodes and Clouds` option under `System Configuration`.\
3\. From the option available on the right side, click on `New Node` button.\
\
4\. Enter the `Node name` \
\
5\. Enable `Permanent Agent` option and click on `OK`.\
\
6\. Enter `/home/bob` under `Remote root directory`.\
\
7\. Enter `node01` under `Labels`.\
\
8\. Select `Only build jobs with label expressions matching this node` option for `Usage`. \
\
9\. Select `Launch Agents via SSH` under `Launch method`.(you have yo install ssh build agent plugin before)\
\
10\. Enter `node01` under `Host` and select the credentials you created before (the jenkins user).\
\
11\. Under `Host Key Verification Strategy`, select `Non verifying verification strategy`.\
\
12\. Leave all other options as it is and click on `Save`\
\
13\. Click on the `linux-node` and there shouldn't be any errors.\
\
14\. Just in case the `linux-node` node is in error state, then try to relaunch it.

\----------------------------------------------------------------

Create a <mark style="color:red;">freestyle job</mark> named `node-job`, and make sure it is restricted to run on `linux-node` node\
\
1\. From dashboard Click on `New Item`.\
\
2\. Enter the job name `node-job`\
\
3\. Select `Freestyle project` and click on `OK`.\
\
4\. In `General` section, select the `Restrict where this project can be run` option and enter `node01` under `Label Expression`.\
\
5\. Under `Build`, select `Execute shell` and enter the command:\


```sh
echo 'hello world'
```

\
\
6\. Finally click on `Save` button.

\-------------------------------------------------------------------

Create a pipeline job named `node-pipeline`, and make sure it is restricted to run on `linux-node` node:&#x20;

Login into the Jenkins server and follow the below given steps:\
\


1\. On the left side click on `New Item`.\
\
2\. Write the job name `node-pipeline`.\
\
3\. Select `Pipeline` job.\
\
4\. <mark style="color:red;">Under</mark> <mark style="color:red;"></mark><mark style="color:red;">`Pipeline`</mark> <mark style="color:red;"></mark><mark style="color:red;">section keep selected</mark> <mark style="color:red;"></mark><mark style="color:red;">`Pipeline script`</mark> <mark style="color:red;"></mark><mark style="color:red;">as</mark> <mark style="color:red;"></mark><mark style="color:red;">`Definition`</mark> <mark style="color:red;"></mark><mark style="color:red;">and add below given code in the</mark> <mark style="color:red;"></mark><mark style="color:red;">`Script`</mark>&#x20;

&#x20;the agent label should be node01

```groovy
pipeline {
    agent {
       label "node01"
    }
    stages {
        stage('Hello') {
            steps {
                echo 'Hello World'
            }
        }
    }
}
```

\
\
5\. Finally save the job.

\----------------------------------------------------------------

Configure Jenkins to prevent builds from running on the `Built-In Node` directly :&#x20;

Navigate to `Manage Jenkins » Manage Nodes and Clouds` screen and change the number of Executors to `0` for the `Built-In Node`.

