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
    }

    post {
        always {
            junit 'results/*_result.xml'
        }
    }
}

