pipeline{
    agent any
  tools{
    nodejs 'node18'
    jdk 'jdk17'
  }
  environment{
    SONAR_HOME = tool 'sonar-scanner'
  }
  stages{
    stage("Clean Workspace"){
        steps{
            cleanWs()
        }
    }
    stage("Git checkout"){
      steps{
        git branch:'master', url:'https://github.com/Yatingambhir85/react-bmi-calculator'
      }
    }
    stage("SONAR-SCANNING"){
      steps{
        withSonarQubeEnv('sonar-server'){
          sh '$SONAR_HOME/bin/sonar-scanner -Dsonar.projectName=bmi-calculator -Dsonar.projectKey=bmi-calculator'
        }
      }
    }
    stage("DOCKER BUILD & PUSH"){
        steps{
            withDockerRegistry(credentialsId: 'dockerhub', toolName:'docker'){
                sh 'docker build -t bmi-calculator .'
                sh 'docker tag bmi-calculator yatingambhir/bmi-calculator:latest'
                sh 'docker push yatingambhir/bmi-calculator:latest'
            }
        }
    }
    stage("Deployment on Docker"){
        steps{
            sh 'docker stop bmi-calculator:latest && docker rm bmi-calculator:latest || true'
            sh 'docker run -itd --name bmi-calc-cicd -p 3000:3000 bmi-calculator:latest'
        }
    }
  }
}
  
    
