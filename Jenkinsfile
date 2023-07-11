// pipeline {
//     agent any
//     tools {
//         maven 'mvn'
//     }
    // options {
    //     buildDiscarder(logRotator(numToKeepStr: '3'))
    // }
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
     options {
        buildDiscarder(logRotator(numToKeepStr: '2'))
    }
    stages {
        stage("mvn build"){
            steps {
                sh "mvn clean package"
            }
        }
        stage("push artifact") {
             steps {
                sh 'cp target/*.war /opt/tomcat_10/webapps'
                archiveArtifacts artifacts: "**/target/*.war"
             }
         }
         stage("uploading artifactId") {
            steps {
                script {
                    pom = readMavenPom file: 'pom.xml' 
                    def nexus_url = "172.31.58.205"

                    nexusArtifactUploader artifacts: 
                                [[artifactId: "${pom.artifactId}", 
                                classifier: '', 
                                file: "target/${pom.artifactId}-${pom.version}.war", 
                                type: "${pom.packaging}"]], 
                                credentialsId: "nexusrepo01", 
                                groupId: "${pom.groupId}", 
                                nexusUrl: "${nexus_url}:8081", 
                                nexusVersion: 'nexus3',
                                protocol: 'http', 
                                repository: 'mvn', 
                                version: "${pom.version}"
                }
            }
         }
         stage("uploading sonarqube"){
            steps {
                script {
                    withSonarQubeEnv(credentialsId: 'nexusrepo') {
                    sh "mvn sonar:sonar"
                    }
                }
            }
         }
         stage("Docker build") {
            environment {
                // Docker_Image = "sanjeev0181/mvn-pipeline:v${BUILD_NUMBER}"
                // REGISTRY_CREDENTIALS = credentials('Dockerhublogin')
            }
            steps {
                script {
                    // sh 'docker build -t ${Docker_Image} .'
                    sh 'docker build -t sanjeev0181/mvn-pipeline:v${BUILD_NUMBER} .'
                    echo "Docker Image Tag Name ---> ${dockerImageTag}"
            //         def dockerImage = docker.image("${Docker_Image}}")
            //         withDockerRegistry(credentialsId: 'Dockerhublogin', url: 'https://hub.docker.com/') { 
            //             dockerImage.push("${env.BUILD_NUMBER}")
            //             dockerImage.push("latest")
                    }
                }
             }
         }
         
     }
