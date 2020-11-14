// anchore plugin for jenkins: https://www.jenkins.io/doc/pipeline/steps/anchore-container-scanner/

pipeline {
  environment {
    // don't think registry is required if we're using docker hub
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
    stage('Re-tag as prod and push stable image to registry') {
      steps {
        //manual retagging isn't necessary since we just pass "prod" to dockerImage.push
        //sh 'docker tag ' + repository + ":${BUILD_NUMBER} " + repository + ":prod"
        script {
          docker.withRegistry('', registryCredential) {
            dockerImage.push('prod')
          }
        }
      }
    }
  }
}
