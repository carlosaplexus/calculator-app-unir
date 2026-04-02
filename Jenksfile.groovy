pipeline {

    agent { 
        label 'docker' 
    }

    stages {

        stage('Build Docker Image') {
            steps {
                sh 'make build'
            }
        }

        stage('Unit Tests') {
            steps {
                sh 'make test-unit'
                archiveArtifacts artifacts: "results/*.xml"
            }
        }

        stage('API Tests') {
            steps {
                sh 'make test-api'
                archiveArtifacts artifacts: "results/*.xml"
            }
        }

        stage('E2E Tests') {
            steps {
                sh 'make test-e2e'
                archiveArtifacts artifacts: "results/*.xml"
            }
        }
    }

    post {
        always {
            junit 'results/*_result.xml'
        }
    }
}

