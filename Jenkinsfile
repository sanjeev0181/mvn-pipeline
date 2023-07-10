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
                    def pom = readMavenPom file: "pom.xml";
                    echo "artifact-d--> ${pom.artifactId}"
                    echo "groupid-d --> ${pom.groupId}"
                    echo "packing-d --> ${pom.packaging}"
                    echo "version-d -- > ${pom.version}"
                    sh "pwd"
                    sh "ls -ltra"
                    
                    nexusArtifactUploader artifacts: [[artifactId: '${pom.artifactId}', 

                                                    classifier: '', file: 'target/${pom.artifactId}-${pom.version}.${pom.packaging}',
                                                    type: '${pom.packaging}']], 
                                                    credentialsId: 'nexusrepo', 
                                                    groupId: '${pom.groupId}', 
                                                    nexusUrl: '3.94.8.130:8081', 
                                                    nexusVersion: 'nexus3', 
                                                    protocol: 'http', 
                                                    repository: 'mvn', 
                                                    version: '${pom.version}'
                     }
                }
            }
        }      

    }

