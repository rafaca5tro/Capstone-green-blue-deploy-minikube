pipeline {
  agent any
  stages {
    stage('Hadolint') {
      agent {
        docker {
          image 'hadolint/hadolint'
        }

      }
      steps {
        sh 'hadolint --ignore DL3006 Dockerfile'
      }
    }

    stage('Build Docker Image') {
      steps {
        withCredentials(bindings: [[$class: 'UsernamePasswordMultiBinding', credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD']]) {
          sh '''
						docker build -t vonbolan/capstone .
					'''
        }

      }
    }

    stage('Push Image To Dockerhub') {
      steps {
        withCredentials(bindings: [[$class: 'UsernamePasswordMultiBinding', credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD']]) {
          sh '''
						docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
						docker push vonbolan/capstone
					'''
        }

      }
    }

    stage('Create conf file cluster') {
      steps {
        withAWS(region: 'us-east-2', credentials: 'capstone') {
          sh '''
						aws eks --region us-west-2 update-kubeconfig --name capstone
					'''
        }

      }
    }

    stage('Set current kubectl context') {
      steps {
        withAWS(region: 'us-east-2', credentials: 'capstone') {
          sh '''
						kubectl config use-context arn:aws:iam::482702493340:role/ekscapstone
					'''
        }

      }
    }

    stage('Deploy blue container') {
      steps {
        withAWS(region: 'us-west-2', credentials: 'capstone') {
          sh '''
						kubectl apply -f ./blue-controller.json
					'''
        }

      }
    }

    stage('Deploy green container') {
      steps {
        withAWS(region: 'us-west-2', credentials: 'capstone') {
          sh '''
						kubectl apply -f ./green-controller.json
					'''
        }

      }
    }

    stage('Create the service in the cluster, redirect to blue') {
      steps {
        withAWS(region: 'us-west-2', credentials: 'capstone') {
          sh '''
						kubectl apply -f ./blue-service.json
					'''
        }

      }
    }

    stage('Wait user approve') {
      steps {
        input 'Ready to redirect traffic to green?'
      }
    }

    stage('Create the service in the cluster, redirect to green') {
      steps {
        withAWS(region: 'us-west-2', credentials: 'capstone') {
          sh '''
						kubectl apply -f ./green-service.json
					'''
        }

      }
    }

  }
}