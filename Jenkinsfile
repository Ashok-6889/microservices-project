pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                dir('src') {
                    sh 'docker build -t ashok6889/cartservice:latest .'
                }
            }
        }

        stage('Push') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'docker-cred') {
                        sh 'docker push ashok6889/cartservice:latest'
                    }
                }
            }
        }
    }
}
