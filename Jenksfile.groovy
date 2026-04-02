pipeline {

    agent none
    
    stages {

        stage('Build Docker Image') {
            agent { label 'docker' }
            steps {
                sh 'make build'
            }
        }

        stage('Unit Tests') {
            agent { label 'node' }
            steps {
                sh 'make test-unit'
                archiveArtifacts artifacts: 'results/*.xml'
            }
        }
    }

    post {
        always {
            junit 'results/*_result.xml'
        }
    }
}
