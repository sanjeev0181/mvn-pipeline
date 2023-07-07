pipeline {
    agent any
    tools {
        maven 'mvn'
    }
    options {
        buildDiscarder(logRotator(numToKeepStr: '3'))
    }
    stages {
        stage("build") {
            steps {
                sh 'mvn clean package'
            }
        
        }
        // stage("push artifact") {
        //     steps {
        //         sh 'cp target/*.war /opt/tomcat_10/webapps'
        //     }
        // }
    }

}
