##I completed The bonus jenkins task, which includes:

- Build a simple multi stage Jenkins pipeline.
- Create a Jenkins pipeline to run every 7 days at 9:00 AM Amman time.

## Bouns Task :

**to solve the Bonus Task in one job i will create a new job and :**
- in poll SCM feild :
![image](https://github.com/mohannad200210/Sitech-Internship/assets/95110750/e2b08272-2c57-4ca6-8d07-6ffb037c50f7)

- in the pipeline script i will rebuilt the three pipelines above into a single multi-stage pipeline script :
```
pipeline {
    agent any
    parameters {
        string(name: 'TAG', defaultValue: 'v1.0', description: 'Enter the version tag')
        string(name: 'IMAGENAME', defaultValue: 'tomcat', description: 'Enter the image name')
        string(name: 'PORTNUMBER', defaultValue: '8080', description: 'Enter the port number to expose (e.g., 8888)')
    }
    stages {
        stage('Build Image') {
            steps {
                script {
                    git branch: 'tomcat-project', url: 'https://github.com/mohannad200210/Sitech-Internship.git'
                    sh "docker build -t mohannad200210/${params.IMAGENAME}:${params.TAG} ."
                }
            }
        }

        stage('Push Image') {
            steps {
                script {
                    sh "docker push mohannad200210/${params.IMAGENAME}:${params.TAG}"
                }
            }
        }

        stage('Deploy Image') {
            steps {
                script {
                    sh "docker run -d -p 8888:${params.PORTNUMBER} mohannad200210/${params.IMAGENAME}:${params.TAG}"
                }
            }
        }
    }
}
```

