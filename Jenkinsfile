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

		

	   


	

	}
}
