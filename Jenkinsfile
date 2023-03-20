pipeline{
    agent any
    tools {
        maven 'MVN_HOME'
    }
    environment {
    dockerhub = credentials('dockerhub')
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
                    sh 'podman build -t config-server-img:0.0.1 -f ./Dockerfile .'
                }
            }
        }
    }
}