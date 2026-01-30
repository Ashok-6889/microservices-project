pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                dir('cartservice/src') {
                    sh 'docker build -t ashok6889/cartservice:v1 -f Dockerfile .'
                }
            }
        }

        stage('Push') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'docker-cred') {
                        sh 'docker push ashok6889/cartservice:v1'
                    }
                }
            }
        }
    }
}
