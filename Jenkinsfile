#!groovy
pipeline{

	agent any
	
	tools {
		maven 'MAVEN'
		jdk 'JDK'
	}

	environment {
		DOCKERHUB_CREDENTIALS=credentials('dockerhub-pongchai')
	}

	stages {
		
		stage('Build Package') {
			steps {
      				sh 'mvn clean install package -f complete/pom.xml'
      			}
		}
		
		stage('Stop local container') {
            		steps {
                		catchError(buildResult: 'SUCCESS', stageResult: 'UNSTABLE') {
                    			sh 'docker container stop gs-rest-service'
               			}
            		}
        	}
        
        	stage('Remove existing container') {
            		steps {
                		catchError(buildResult: 'SUCCESS', stageResult: 'UNSTABLE') {
                    			sh 'docker container rm -f gs-rest-service'
                		}
            		}
        	}
		
		stage('Remove existing image') {
            		steps {
                		catchError(buildResult: 'SUCCESS', stageResult: 'UNSTABLE') {
                    			sh 'docker rmi -f pongchai/gs-rest-service'
                		}
            		}
        	}
		
		stage('Build Docker Image') {

			steps {
				sh 'docker build -t pongchai/gs-rest-service:latest .'
			}
		}

		stage('Login') {

			steps {
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
			}
		}

		stage('Push Docker Image') {

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
