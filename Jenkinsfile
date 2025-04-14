pipeline {
  agent any

  environment {
    HTTP_PROXY = 'http://127.0.0.1:9888'
    JAVA_HOME = '/opt/java/11.0.14'
    PATH = "${JAVA_HOME}/bin:${PATH}"
  }

  stages {

    stage('Build') {
      steps {
        sh './gradlew clean assemble'
      }
    }

    stage('Unit Tests') {
      steps {
        sh './gradlew test'
      }
      post {
        always {
          junit 'build/test-results/test/*.xml'
        }
      }
    }

    stage('Database Tests') {
      steps {
        sh './gradlew integrate'
      }
      post {
        always {
          junit 'build/test-results/integrate/*.xml'
        }
      }
    }

    stage('BDD Tests') {
      steps {
        sh './gradlew generateCucumberReports'
        sh './gradlew jacocoTestReport'
      }
      post {
        always {
          junit 'build/test-results/bdd/*.xml'
        }
      }
    }

    stage('Static Analysis') {
      steps {
        sh './gradlew sonarqube -Dsonar.host.url=http://sonarqube:9000 -Dsonar.login="admin" -Dsonar.password="ensf400"'
      }
    }
  }
}
