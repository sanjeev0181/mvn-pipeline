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
        // stage("push artifact") {
        //      steps {
        //         sh 'cp target/*.war /opt/tomcat_10/webapps'
        //         archiveArtifacts artifacts: "**/target/*.war"
        //      }
        //  }
        //  stage("uploading artifactId") {
        //     steps {
        //         script {
        //             pom = readMavenPom file: 'pom.xml' 
        //             def nexus_url = "172.31.58.205"

        //             nexusArtifactUploader artifacts: 
        //                         [[artifactId: "${pom.artifactId}", 
        //                         classifier: '', 
        //                         file: "target/${pom.artifactId}-${pom.version}.war", 
        //                         type: "${pom.packaging}"]], 
        //                         credentialsId: "nexusrepo01", 
        //                         groupId: "${pom.groupId}", 
        //                         nexusUrl: "${nexus_url}:8081", 
        //                         nexusVersion: 'nexus3',
        //                         protocol: 'http', 
        //                         repository: 'mvn', 
        //                         version: "${pom.version}"
        //         }
        //     }
        //  }
         stage("uploading sonarqube"){
            steps {
                script {
                    withSonarQubeEnv(credentialsId: 'newsonar-tocken') {
                    sh "mvn sonar:sonar"
                    }
                }
            }
         }
        //  stage("Docker build") {
        //     steps {
        //         script {
        //             // sh "docker rmi ${imageName} || true"
        //             sh 'docker build -t sanjeev0181/mvn-pipeline:v${BUILD_NUMBER} .'
        //             withCredentials([string(credentialsId: 'dockerhub-login', variable: 'Dockerhublogin')]) {
        //                 sh 'docker login -u sanjeev0181 -p{dockerhub-login}'
        //                 }
        //             sh 'docker push sanjeev0181/mvn-pipeline:v${BUILD_NUMBER}'

        //             }
        //         }
        //      }
         
        //  stage("S3 upload to artifact") {
        //     steps {
        //         script {
        //             s3Upload consoleLogLevel: 'INFO', 
        //             dontSetBuildResultOnFailure: false, 
        //             dontWaitForConcurrentBuildCompletion: false, 
        //             entries: [[bucket: 'jenkins-pipeline-s3/${JOB_NAME}-${BUILD_NUMBER}', 
        //             excludedFile: '/webapps/target', 
        //             flatten: false, 
        //             gzipFiles: false, 
        //             keepForever: false, 
        //             managedArtifacts: false, 
        //             noUploadOnFailure: false,
        //              selectedRegion: 'us-east-1', 
        //              showDirectlyInBrowser: false, 
        //              sourceFile: '**/target/*.war', 
        //              storageClass: 'STANDARD', 
        //              uploadFromSlave: false, useServerSideEncryption: false]], 
        //              pluginFailureResultConstraint: 'SUCCESS', 
        //              profileName: 'jenkins-pipeline-s3', 
        //              userMetadata: []
        //         }
        //     }
        //  }
         
     }
}



