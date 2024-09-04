pipeline {
	agent { label 'Jenkins-Agent'}
	tools {
		jdk 'java17'
		maven 'Maven3'
		}

	environment {
		APP_NAME = "register-app-pipeline"
		RELEASE = "2.1.0"
		DOCKER_USER = "chvsyamkumar"
		DOCKER_PASS = "DockerHub"
		IMAGE_NAME = "${DOCKER_USER}" + "/" + "${APP_NAME}"
		IMAGE_TAG = "${RELEASE}-${BUILD_NUMBER}"
		JENKINS_API_TOKEN = credentials("JENKINS_API_TOKEN")
}
	
		
	stages{
		stage("Cleanup Workspace"){
			steps {
			cleanWs()
			}
		}
		
		stage("Checkout fromSCM"){
			steps {
				git branch: 'patch-1', credentialsId: 'github', url: 'https://github.com/chvsyam/registration-app.git'
			}
		}
		
		stage("Build Application"){
			steps {
				sh "mvn clean package"
			}
		}
		
		stage("Test Application"){
			steps{
				sh "mvn test"
			}
		}

		stage("SonarQube Analysis"){
			steps {
		script {
			withSonarQubeEnv(credentialsId: 'jenkins-sonarqube-token') {
				sh "mvn sonar:sonar"
				}
				}
			}
		}

		stage("Build & Push,DockerImage"){
	steps {
		script {
			docker.withRegistry('',DOCKER_PASS) {
				docker_image = docker.build "${IMAGE_NAME}"
			}
			
			docker.withRegistry('',DOCKER_PASS){
				docker_image.push("${IMAGE_TAG}")
				docker_image.push('latest')
			}
		}
	}
}


		stage("Trivy Scan") {
           steps {
               script {
	            sh ('docker run -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy image chvsyamkumar/register-app-pipeline:latest --no-progress --scanners vuln  --exit-code 0 --severity HIGH,CRITICAL --format table')
               }
           }
       }
	   
stage ('Cleanup Artifacts') {
           steps {
               script {
                    sh "docker rmi ${IMAGE_NAME}:${IMAGE_TAG}"
                    sh "docker rmi ${IMAGE_NAME}:latest"
               }
          }
       }

stage("Trigger CD Pipeline") {
            steps {
                script {
                    sh "curl -v -k --user clouduser:${JENKINS_API_TOKEN} -X POST -H 'cache-control: no-cache' -H 'content-type: application/x-www-form-urlencoded' --data 'IMAGE_TAG=${IMAGE_TAG}' 'ec2-54-167-36-191.compute-1.amazonaws.com:8080/job/Register-App-CD/buildWithParameters?token=gitops-token'"
                }
            }
       }
    

		


	

		

	   


	

	}
}
