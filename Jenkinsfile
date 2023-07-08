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
        stage("push artifact") {
            steps {
                sh 'cp target/*.war /opt/tomcat_10/webapps'
            }
        }
        stage("Upload war to nexus"){
            steps {
                nexusArtifactUploader artifacts: [[artifactId: 'funds-1.0', classifier: '', file: 'target/funds-1.0-5.0.0', type: 'war']], credentialsId: 'nexusrepo', groupId: 'icic', nexusUrl: '172.31.80.58', nexusVersion: 'nexus3', protocol: 'http', repository: 'mvn', version: '5.0.0'
            }
        }
    }

}
