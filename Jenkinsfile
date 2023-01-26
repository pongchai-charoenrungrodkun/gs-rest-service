#!groovy
pipeline{

	agent any

	environment {
		DOCKERHUB_CREDENTIALS=credentials('dockerhub-pongchai')
	}

	stages {
		
		stage('Build Package') {
			steps {
				sh 'export PATH=/usr/local/bin/:/opt/homebrew/opt/openjdk/bin:/opt/apache-maven-3.8.7/bin:$PATH'
      				sh 'mvn clean install package -f complete/pom.xml'
      			}
		}
		
		stage('Build Docker Image') {

			steps {
				sh 'export PATH=/usr/local/bin/:/opt/homebrew/opt/openjdk/bin:/opt/apache-maven-3.8.7/bin:$PATH'
				sh 'docker build -t pongchai/gs-rest-service:latest .'
			}
		}

		stage('Login') {

			steps {
				sh 'export PATH=/usr/local/bin/:/opt/homebrew/opt/openjdk/bin:/opt/apache-maven-3.8.7/bin:$PATH'
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
			}
		}

		stage('Push Docker Image') {

			steps {
				sh 'export PATH=/usr/local/bin/:/opt/homebrew/opt/openjdk/bin:/opt/apache-maven-3.8.7/bin:$PATH'
				sh 'docker push pongchai/gs-rest-service:latest'
			}
		}
	}

	post {
		always {
			sh 'export PATH=/usr/local/bin/:/opt/homebrew/opt/openjdk/bin:/opt/apache-maven-3.8.7/bin:$PATH'
			sh 'docker logout'
		}
	}

}
