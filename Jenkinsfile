pipeline {
    // Defines the agent for the pipeline, can be a specific label or Docker agent
    agent any
 
    // Environment variables
    environment {
        // The name of your Docker image
        IMAGE_NAME = "Django-todo"
        // The version tag for your image
        IMAGE_TAG = "v1.0"
        // The IP address where you want to run the container (e.g., your Jenkins agent's IP)
        RUN_IP = "13.201.72.245"
    }
 
    stages {
        stage('Checkout Code') {
            steps {
                // Clones your repository
                git url: 'https://github.com/Sankar147/django-todo.git', branch: 'main'
            }
        }
 
        stage('Build Docker Image') {
            steps {
                script {
                    // Navigate to the directory containing your Dockerfile
                    sh 'cd src/'
                    // Build the Docker image
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
                    
                    // Run the container, mapping port 8080 on the host to port 80 in the container
                    sh "docker run -d --name ${IMAGE_NAME} -p 8080:80 --ip ${RUN_IP} ${IMAGE_NAME}:${IMAGE_TAG}"
                }
            }
        }
    }
}
