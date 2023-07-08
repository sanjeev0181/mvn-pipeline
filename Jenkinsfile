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
                nexusArtifactUploader artifacts: [[artifactId: 'funds', classifier: '', file: 'target/funds-5.0.0.war', type: 'war']], credentialsId: 'nexusrepo', groupId: 'icic', nexusUrl: '172.31.80.58', nexusVersion: 'nexus3', protocol: 'http', repository: 'mvn', version: '5.0.0'
            }
        }
    }

}
