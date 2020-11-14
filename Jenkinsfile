// anchore plugin for jenkins: https://www.jenkins.io/doc/pipeline/steps/anchore-container-scanner/

pipeline {
  environment {
    registry = 'registry.hub.docker.com'
    // you need a credential named 'docker-hub' with your DockerID/password to push images
    registryCredential = 'docker-hub'
    // change this repository and imageLine to your DockerID
    repository = 'pvnovarese/jenkins-demo'
    imageLine = "pvnovarese/jenkins-demo:${BUILD_NUMBER} Dockerfile"
  }
  agent any
  stages {
    stage('Checkout SCM') {
      steps {
        checkout scm
      }
    }
    stage('Build image and push to registry') {
      steps {
        // docker --version just for a sanity check that everything is running
        sh 'docker --version'
        script {
          dockerImage = docker.build repository + ":${BUILD_NUMBER}"
          docker.withRegistry( '', registryCredential ) { 
            dockerImage.push() 
          }
        }
      }
    }
    stage('Analyze with Anchore plugin') {
      steps {
        writeFile file: 'anchore_images', text: imageLine
        anchore name: 'anchore_images', forceAnalyze: 'true', engineRetries: '900'
      }
    }
    stage('Build and push stable image to registry') {
      steps {
        //sh 'docker tag ' + repository + ":${BUILD_NUMBER} " + repository + ":prod"
        script {
          //image = docker.image(repository + ":prod")
          docker.withRegistry('', registryCredential) {
            dockerImage.push('prod')
          }
        }
        // script {
          // docker.withRegistry('https://' + registry, registryCredential) {
            // def image = docker.build(repository + ':prod')
            // image.push()  
          // }
        // }
      }
    }
  }
}
