pipeline{
    agent any
    tools {
        maven 'MVN_HOME'
    }
    environment {
    dockerhub = credentials('dockerhub')
    }
    stages {
        stage('Verify tools') {
            steps {
                    sh '''
                        docker info
                        docker version
                        docker compose version
                        curl --version
                      '''
            }
        }
        stage('Build Maven') {
            steps{
                checkout([$class: 'GitSCM', branches: [[name: '*/feature/config-server']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/VK-11/config-server.git']]])
                sh "mvn clean install -DskipTests -DsendCredentialsOverHttp=true"
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                   sh 'docker build -t config-server-img:1.0 -f ./Dockerfile .'
                }
            }
        }
        stage('Deploy Docker Image') {
            steps {

                    sh 'docker tag config-server-img:1.0 configServer/config-server-img:1.0'
                    sh 'docker login 172.23.96.1:10082 --username=vikas --password=vikas'
                    sh 'docker push configServer/config-server-img:1.0'
            }
        }
    }
}