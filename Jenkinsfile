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
      cleanWs()
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
  }
}
  
    
