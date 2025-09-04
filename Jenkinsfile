pipeline {
    agent { label 'calchub' }

    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out source code...'
                checkout scm
            }
        }

        stage('Pre-Build Cleanup') {
            steps {
                echo 'Pruning unused Docker resources before build...'
                sh '''
                    docker-compose down --remove-orphans --volumes || true
                    docker container rm -f node-backend || true
                    docker container rm -f react-frontend || true
                    docker system prune -f --volumes || true
                '''
            }
        }

        stage('Build and Deploy') {
            steps {
                echo 'Building and starting Docker containers...'
                sh '''
                    docker-compose build --no-cache
                    docker-compose up -d
                '''
            }
        }
    }

    post {
        failure {
            echo 'Build or deployment failed. Please check the logs above for details.'
        }
        success {
            echo 'Build and deployment succeeded!'
        }
        always {
            echo 'Build and deployment process finished.'
            sh 'docker-compose ps'
        }
    }
}