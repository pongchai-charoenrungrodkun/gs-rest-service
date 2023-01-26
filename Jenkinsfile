#!groovy
pipeline{

	agent any

	environment {
		DOCKERHUB_CREDENTIALS=credentials('dockerhub-pongchai')
	}

	stages {

		stage('Build') {

			steps {
				sh 'docker build -t pongchai/gs-rest-service:latest .'
			}
		}

		stage('Login') {

			steps {
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
			}
		}

		stage('Push') {

			steps {
				sh 'docker push pongchai/gs-rest-service:latest'
			}
		}
	}

	post {
		always {
			sh 'docker logout'
		}
	}

}
