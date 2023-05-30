pipeline{
    agent any

    tools {
            maven 'maven-3.9.0'
            jdk 'openjdk11'
        }

    stages {

        stage('Build Maven') {
            steps{
                checkout([$class: 'GitSCM', branches: [[name: '*/feature/config-server']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/VK-11/config-server.git']]])
                sh "mvn clean install -DskipTests"
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                   sh 'docker build -t config-server-img:1.0 -f ./Dockerfile.layered .'
                }
            }
        }
        stage('Deploy Docker Image') {
            steps {

                    sh 'docker tag config-server-img:1.0 172.23.96.1:10082/docker-server/config-server-img:1.0'
                    sh 'docker login http://172.23.96.1:10082/repository/docker-server/ --username=vikas --password=vikas'
                    sh 'docker push 172.23.96.1:10082/docker-server/config-server-img:1.0'
            }
        }
    }
}