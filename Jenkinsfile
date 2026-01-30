pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh '''
                  echo "=== Build context ==="
                  ls -la src

                  docker build \
                    --no-cache \
                    -t ashok6889/cartservice:v1 \
                    -f src/Dockerfile \
                    src
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
