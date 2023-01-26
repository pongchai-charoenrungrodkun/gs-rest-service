#!groovy
pipeline{

	agent any

	environment {
		DOCKERHUB_CREDENTIALS=credentials('dockerhub-pongchai')
	}

	stages {
		
		stage('Build Package') {
			steps {
      				sh '/opt/apache-maven-3.8.7/bin/mvn clean install package -f complete/pom.xml'
      			}
		}
		
		stage('Build Docker Image') {

			steps {
				sh '/usr/local/bin/docker build -t pongchai/gs-rest-service:latest .'
			}
		}

		stage('Login') {

			steps {
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | /usr/local/bin/docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
			}
		}

		stage('Push Docker Image') {

			steps {
				sh '/usr/local/bin/docker push pongchai/gs-rest-service:latest'
			}
		}
	}

	post {
		always {
			sh '/usr/local/bin/docker logout'
		}
	}

}
