pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh '''
                  echo "=== Build context ==="
                  ls -la cartservice/src

                  docker build \
                    --no-cache \
                    -t ashok6889/cartservice:v1 \
                    -f cartservice/src/Dockerfile \
                    cartservice/src
                '''
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
