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
                nexusArtifactUploader artifacts: [[artifactId: 'funds', classifier: '', 
                                            file: 'target/funds-1.0-SNAPSHOT.war', type: 'war']], 
                                            credentialsId: 'nexusrepo', groupId: 'icic', 
                                            nexusUrl: '172.31.80.58', nexusVersion: 'nexus3', 
                                            protocol: 'http', repository: 'http://ec2-34-238-135-158.compute-1.amazonaws.com:8081/repository/mvn-pipeline', version: '1.0-SNAPSHOT'
            }
        }
    }

}
