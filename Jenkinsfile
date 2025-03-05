pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Check Workspace') {
            steps {
                sh 'ls -l'  // List files to verify manage.py is present
            }
        }

        stage('Build Image') {
            steps {
                script {
                    def imageName = "naniy9836/myshop:latest"

                    // Build Docker image
                    sh "docker build --no-cache -t ${imageName} ."

                    // Login and push to Docker Hub
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                        sh "docker login -u ${USERNAME} -p ${PASSWORD}"
                        sh "docker push ${imageName}"
                    }
                }
            }
        }
    }
}
