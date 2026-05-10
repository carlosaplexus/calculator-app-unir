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

        // //solo incluido para forzar el error y probar el post failure
        // stage('Simular error') {
        //     steps {
        //         sh 'exit 1' 
        //     }
        // }        

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

        stage('Publicar Reportes') {
            steps {

                junit 'results/*_result.xml' 

                publishHTML(target: [
                    reportDir: 'results/unit',
                    reportFiles: 'index.html',
                    reportName: 'Unit Tests Report'
                ])

                publishHTML(target: [
                    reportDir: 'results/api',
                    reportFiles: 'index.html',
                    reportName: 'API Tests Report'
                ])

                publishHTML(target: [
                    reportDir: 'results/coverage',
                    reportFiles: 'index.html',
                    reportName: 'Cobertura de Código'
                ])

                publishHTML(target: [
                    reportDir: 'results/e2e',
                    reportFiles: 'index.html',
                    reportName: 'Reporte E2E'
                ])
            }
        }

    }

    post {
        failure {

            echo "Job: ${JOB_NAME}"
            echo "Ejecución: #${BUILD_NUMBER}"
            echo "URL: ${BUILD_URL}"           
    //         mail to: 'correo@ejemplo.com',
    //             subject: "Fallo en el job ${JOB_NAME} #${BUILD_NUMBER}",
    //             body: """El pipeline ha fallado.

    //         Job: ${JOB_NAME}
    //         Ejecución: #${BUILD_NUMBER}
    //         URL: ${BUILD_URL}

    //         Revise los logs para más detalles.

    //         Notificación automática desdeJenkins
    //         """
        }
    }
}

