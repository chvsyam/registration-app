pipeline {
	agent { label 'Jenkins-Agent'}
	tools {
		jdk 'java17'
		maven 'Maven3'
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

		stage("Quality Gate") {
    steps {
        script {
            waitForQualityGate abortPipeline: true, credentialsId: 'jenkins-sonarqube-token'
        }
    }
}

	

		

	   


	

	}
}
