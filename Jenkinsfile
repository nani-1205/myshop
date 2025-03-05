pipeline {
    agent {
        node {
            label 'docker-agent' // Replace 'docker-agent' with the label of your Jenkins agent that has Docker
        }
    }
    stages {
        stage('Build Image') {
            steps {
                script {
                    // Replace with your Docker Hub username and image name
                    def imageName = "naniy9836/myshop:latest"

                    // Build the Docker image
                    sh "docker build -t ${imageName} ."
                    //Login to dockerhub
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                        sh "docker login -u ${USERNAME} -p ${PASSWORD}"

                        // Push the Docker image to Docker Hub
                        sh "docker push ${imageName}"
                    }


                }
            }
        }
    }
}