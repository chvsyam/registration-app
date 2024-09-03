pipeline {
	agent { label 'Jenkins-Agent'}
	tools {
		jdk 'Java17'
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
				git branch: 'main', credentialsId: 'github', url: 'https://github.com/chvsyam/registration-app.git'
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
	
	}
}
