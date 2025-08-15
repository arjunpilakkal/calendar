pipeline {
  agent any

  environment {
    DOCKERHUB_USER = 'arjunpdas'   
    IMAGE_NAME     = 'calendar-app'
    IMAGE_TAG      = 'latest'
  }

  stages {
    stage('Checkout') {
      steps {
        git branch: 'main', url: 'https://github.com/arjunpilakkal/calendar.git'
      }
    }

    stage('Build Docker Image') {
      steps {
        sh 'docker build -t $DOCKERHUB_USER/$IMAGE_NAME:$IMAGE_TAG .'
      }
    }

    stage('Push to Docker Hub') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerHub', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
          sh 'echo $PASS | docker login -u $USER --password-stdin'
          sh 'docker push $DOCKERHUB_USER/$IMAGE_NAME:$IMAGE_TAG'
        }
      }
    }

    stage('Run Container') {
      steps {
        sh 'docker rm -f calendar || true'
        sh 'docker run -d --name calendar -p 9090:8080 $DOCKERHUB_USER/$IMAGE_NAME:$IMAGE_TAG'
      }
    }
  }

  post {
    always {
      sh 'docker logout || true'
    }
  }
}
