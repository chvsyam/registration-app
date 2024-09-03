pipeline {
	agent { label 'Jenkins-Agent'}
	tools {
		jdk 'Java17'
		maven 'Maaven3'
		}
		
	stages{
		stage("Cleanup Workspace"){
			steps {
			cleanWs()
			}
		}
		
		stage("Checkout fromSCM"){
			steps {
				git branch: 'main', credentialsId: 'github', url: 'https://github.com/Ashfaque-9x/registration-app'
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
