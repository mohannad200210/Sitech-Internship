# Pipeline

A `Jenkinsfile` is a text file that contains the definition of a Jenkins Pipeline.

all your files for pipeline job will be under&#x20;

```
 /var/lib/jenkins/workspace/[pipeline name]
```

<pre><code><strong>simple CD
</strong><strong>
</strong><strong>pipeline {
</strong>    agent {
        label {
            label 'master'
            customWorkspace "${JENKINS_HOME}/${BUILD_NUMBER}/"
        }
    }
    environment {
        Go111MODULE='on'
    }
    stages {
        stage('Test') {
            steps {
                git 'https://github.com/kodekloudhub/go-webapp-sample.git'
                sh 'go test ./...'
            }
        }
    }
}

</code></pre>

```
Docker image func :

pipeline {
    agent {
        label {
            label 'master'
            customWorkspace "${JENKINS_HOME}/${BUILD_NUMBER}/"
        }
    }
    environment {
        Go111MODULE='on'
    }
    stages {
        stage('Test') {
            steps {
                git 'https://github.com/kodekloudhub/go-webapp-sample.git'
            }
        }
        stage('build') {
            steps {
                script{
                    image = docker.build("adminturneddevops/go-webapp-sample")
                }
            }
        }
    }
}
```

```
Full CI/CD

pipeline {
    agent {
        label {
            label 'master'
            customWorkspace "${JENKINS_HOME}/${BUILD_NUMBER}/"
        }
    }
    environment {
        Go111MODULE='on'
    }
    stages {
        stage('Test') {
            steps {
                git 'https://github.com/kodekloudhub/go-webapp-sample.git'
            }
        }
        stage('build') {
            steps {
                script{
                    image = docker.build("adminturneddevops/go-webapp-sample")
                    sh "docker run -p 8090:8000 -d adminturneddevops/go-webapp-sample"
                }
            }
        }
    }
}
```
