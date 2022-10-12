pipeline {
    agent any

    stages {

        stage('Initial Cleanup') {
            steps {
            dir("${WORKSPACE}") {
              deleteDir()
                }
            }
        }

        stage ('Checkout Repo'){
            steps {

                git branch: 'main', url: 'https://github.com/Godwinjulin/Jenkins-docker-pipeline.git'
            }
        }

        stage ('Build Docker Image') {
            steps {
                script {

                       sh "docker build -t brini:${env.BRANCH_NAME}-${env.BUILD_NUMBER} ."
                }
            }
        }

        stage ('Run Container') {
            steps {
                script {

                       sh "docker run --network php -p 8050:8000 -d brini:${env.BRANCH_NAME}-${env.BUILD_NUMBER} ."
                }
            }
        }

        stage ('Test-Stage-Curl') {
            steps {
                script {

                    sh "curl --version"
                    sh  "curl -I http://3.95.65.147:8050"
                }
            }
        }


        stage ('Push Docker Image') {
            steps{
                script {
            sh "docker login -u ${env.username} -p ${env.password}"

            sh "docker push brini:${env.BRANCH_NAME}-${env.BUILD_NUMBER}"
                }
            }
        }


        stage ('Clean Up') {
            steps{
                script {

            sh "docker system prune -af"

                }
            }
        }


        stage ('logout Docker') {
            steps {
                script {

                    sh "docker logout"

                }
            }
        }

    }
}