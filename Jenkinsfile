pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh "docker build -t ashok6889/productcatalogservice:v1 ."
            }
        }
        stage('push'){
            steps {
                script {
                    withDockerRegistry(credentialsId: 'docker-cred') {
                        sh 'docker push ashok6889/productcatalogservice:v1'
                    }
                }
            }
        }
    }
}
