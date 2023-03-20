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
                   sh 'docker build -t config-server-img:1.0 .'
                }
            }
        }
        stage('Deploy Docker Image') {
            steps {

                    sh 'docker tag config-server-img:1.0 vikaskaushik93/config-server-img:1.0'
                    sh 'docker login --username=$dockerhub_USR --password=$dockerhub_PSW'
                    sh 'docker push vikaskaushik93/config-server-img:1.0'
            }
        }
    }
}