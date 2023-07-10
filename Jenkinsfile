// pipeline {
//     agent any
//     tools {
//         maven 'mvn'
//     }
//     options {
//         buildDiscarder(logRotator(numToKeepStr: '3'))
//     }
//     stages {
//         stage("build") {
//             steps {
//                 sh 'mvn clean package'
//             }
        
//         }
//         stage("push artifact") {
//             steps {
//                 sh 'cp target/*.war /opt/tomcat_10/webapps'
//             }
//         }
//         stage("Upload war to nexus"){
//             steps {
//                 script {
//                     nexusArtifactUploader artifacts: [[artifactId: 'nexus-repo', 
//                                                   classifier: '', file: 'target/nexus-repo-5.0.0.war', 
//                                                   type: 'war']], 
//                                                   credentialsId: 'nexusrepo', 
//                                                   groupId: 'icic', 
//                                                   nexusUrl: '3.94.8.130:8081', 
//                                                   nexusVersion: 'nexus3',
//                                                   protocol: 'http', 
//                                                   repository: 'mvn', 
//                                                   version: '5.0.0'
//                 }
//             }
//         }
//     }

// }


pipeline {
    agent any 

    stages {
        stage("mvn build"){
            steps {
                sh "mvn clean package"
            }
        }
        stage("push artifact") {
             steps {
                 sh 'cp target/*.war /opt/tomcat_10/webapps'
             }
         }
         stage("uploading artifactId") {
            steps {
                script {
                    sh "ls -ltra"
                    sh " cd target/*.war"
                    // #sh " cp target/nexus-repo-6.0.0.war  /root/.jenkins/workspace/mvn-pipeline@tmp/durable-e4269f7b/"
                    def pom = readMavenPom file: 'pom.xml' 
                    nexusArtifactUploader artifacts: 
                                [[artifactId: '${pom.artifactId}', 
                                classifier: '', 
                                file: 'target/nexus-repo-6.0.0.war', 
                                type: '${pom.packaging}']], 
                                credentialsId: 'nexusrepo', 
                                groupId: '${pom.groupId}', 
                                nexusUrl: '172.31.80.58', 
                                nexusVersion: 'nexus3',
                                protocol: 'http', 
                                repository: 'mvn', 
                                version: '${pom.version}'
                }
            }
         }
    }

}
