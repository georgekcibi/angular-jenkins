pipeline {
    agent any

environment {
    dockerhub = credentials('dockerhub')
    registry  = "georgekc/angular"
}

 stages {

    stage('Stopping running container') {
        steps {
            sh 'sudo docker stop angular || true'
        }
    }

    stage('Clonning repro') {
     steps {
             git branch: 'angular', changelog: false, poll: true, url: 'https://github.com/georgekcibi/angular-jenkins.git'
            }
        }


    stage('Build Docker Image and tag it') {
    steps {
        sh 'sudo docker build -t angular .'
        sh 'sudo docker tag angular:latest $registry:latest'
    }
   }

    stage('Push Docker image to the registry') {
     steps {
        withDockerRegistry([ credentialsId: "dockerhub", url: "" ]) {
            sh 'sudo docker push $registry:latest'

        }
        }
   }

    stage('Tagging image') {
        steps {
            sh 'sudo docker tag $registry:latest $registry:$BUILD_NUMBER'
            sh 'sudo docker run -p 4200:4200 -d --name angular $registry:$BUILD_NUMBER'

        }
    }

 }

}
