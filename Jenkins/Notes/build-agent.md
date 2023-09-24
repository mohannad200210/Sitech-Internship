# build agent

A build agent is typically a machine, or container, which connects to a Jenkins controller and executes tasks when directed by the controller.

build agent can be any os/system(docker) that have java on it

Just like Jenkins server , `java` is a pre-requisite for a Jenkins agent node as well.

to using build agent :&#x20;

Install `SSH Build Agents` Jenkins plugin.&#x20;



you can test your project in windows for example by create a build agent foit (and the conection will be using ssh the steps in daily reop



the build agent could be a docker container (just write this in agent block without any other configuration ) :&#x20;

```
pipeline {
    agent {
        docker { image 'golang:latest' }
    }
    stages {
        stage('Development') {
            steps {
                git 'https://github.com/AdminTurnedDevOps/go-webapp-sample.git'
                sh 'go version'
            }
        }
    }
}
```

