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
    tools {
        maven 'mvn'
    }
    
    options {
        buildDiscarder(logRotator(numToKeepStr: '9'))
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
         stage("publish to nexus") {
            steps {
                script {
                    def mavenPom = readMavenPom file: "pom.xml";
                    

                        nexusArtifactUploader artifacts: [[artifactId: '${mavenPom.artifactId}', 

                                                    classifier: '', file: 'target/${mavenPom.artifactId}.war',
                                                    type: '${mavenPom.packaging}']], 
                                                    credentialsId: 'nexusrepo', 
                                                    groupId: '{mavenPom.groupId}', 
                                                    nexusUrl: '3.94.8.130:8081', 
                                                    nexusVersion: 'nexus3', 
                                                    protocol: 'http', 
                                                    repository: 'mvn', 
                                                    version: '${mavenPom.version}'
                    
                    
                }
            }
        }      

    }

}
