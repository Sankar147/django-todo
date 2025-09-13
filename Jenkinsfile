pipeline {
    agent any

    environment {
        IMAGE_NAME = "Django-todo"
        IMAGE_TAG = "v1.0"
        RUN_IP = "13.201.72.245"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git url: 'https://github.com/Sankar147/django-todo.git', branch: 'main'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Print current dir and files for debugging (optional)
                    sh 'pwd && ls -la'

                    // Build the Docker image from current directory
                    sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Stop and remove any existing container with the same name
                    sh "docker stop ${IMAGE_NAME} || true"
                    sh "docker rm ${IMAGE_NAME} || true"

                    // Run the container on port 8080 -> 80
                    sh "docker run -d --name ${IMAGE_NAME} -p 8080:80 ${IMAGE_NAME}:${IMAGE_TAG}"
                }
            }
        }
    }
}
