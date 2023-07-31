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
    // Maven build step 
    stages {
        stage("mvn build"){
            steps {
                sh "mvn clean package"
            }
        }
        // tomcat deploy step 
        stage("push artifact") {
             steps {
                sh 'cp target/*.war /opt/tomcat_10/webapps'
                archiveArtifacts artifacts: "**/target/*.war"
             }
         }
        //  nexus uploading to artifactid
        // pipeline-utility-steps install pligin on jenkins server
         stage("uploading artifactId") {
            steps {
                script {
                    pom = readMavenPom file: 'pom.xml' 
                    def nexus_url = "52.86.35.87"

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
        //  sonarqube scaner
         stage("uploading sonarqube"){
            steps {
                script {
                    withSonarQubeEnv(credentialsId: 'jenkinssonarqube') {
                    sh "mvn sonar:sonar"
                    }
                }
            }
         }
        //  docker buils and push 
         stage("Docker build") {
            steps {
                script {
                    echo "*************** This is build stage **********"
                    sh 'docker build -t sanjeev0181/mvn-pipeline:v${BUILD_NUMBER} .'
                    echo "********** Pushing image to Dockerhub ***********"
                    withCredentials([string(credentialsId: 'Dockerhublogin02', variable: 'Docker')]) {
                    sh 'docker login -u sanjeev0181 -p ${Docker}'
                    }
                    sh 'docker push sanjeev0181/mvn-pipeline:v${BUILD_NUMBER}'

                    }
                }
             }
        //  send war on s3 bucket
         stage("S3 upload to artifact") {
            steps {
                script {
                    echo " *************** S3 Upload to artifact **************** "
                    s3Upload consoleLogLevel: 'INFO', 
                    dontSetBuildResultOnFailure: false, 
                    dontWaitForConcurrentBuildCompletion: false, 
                    entries: [[bucket: 'jenkins-pipeline-s3/${JOB_NAME}-${BUILD_NUMBER}', 
                    excludedFile: '/webapps/target', 
                    flatten: false, 
                    gzipFiles: false, 
                    keepForever: false, 
                    managedArtifacts: false, 
                    noUploadOnFailure: false,
                     selectedRegion: 'us-east-1', 
                     showDirectlyInBrowser: false, 
                     sourceFile: '**/target/*.war', 
                     storageClass: 'STANDARD', 
                     uploadFromSlave: false, useServerSideEncryption: false]], 
                     pluginFailureResultConstraint: 'SUCCESS', 
                     profileName: 'jenkins-pipeline-s3', 
                     userMetadata: []
                }
            }
            // slack notifaction
            post {
                always {
                    slackSend channel: '#mvn-pipeline', message: "This build is scucess on ${JOB_NAME}-${BUILD_NUMBER}"
                    }
            }
        }
         
         
     }
}



