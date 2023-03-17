pipeline {
    agent any
    tools{
        maven 'MVN_HOME'
    }
    stages{
        stage('Build Maven'){
            steps{
                checkout([$class: 'GitSCM', branches: [[name: '*/feature/config-server']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/VK-11/config-server.git']]])
                sh 'mvn clean install -DskipTests'
            }
        }
        stage('Build docker image'){
            steps{
                script{
                    sh 'docker build -t sg/configserver'
                }
            }
        }
    }
}