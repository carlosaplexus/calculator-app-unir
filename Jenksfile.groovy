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

        failure {
            mail to: 'tu_correo@dominio.com',
                subject: "Fallo en el job ${JOB_NAME} #${BUILD_NUMBER}",
                body: """El pipeline ha fallado.

Job: ${JOB_NAME}
Ejecución: #${BUILD_NUMBER}
URL: ${BUILD_URL}

Revise los logs para más detalles.

Notificación automática desde Jenkins
"""
        }

        always {
            script {
                node('docker') {
                    junit 'results/*_result.xml'

                    publishHTML(target: [
                        reportDir: 'results/coverage',
                        reportFiles: 'index.html',
                        reportName: 'Cobertura de Código'
                    ])

                    publishHTML(target: [
                        reportDir: 'results',
                        reportFiles: 'index.html',
                        reportName: 'Reporte E2E'
                    ])
                }
            }
        }
    }
}

