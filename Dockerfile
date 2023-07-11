# FROM centos:latest

# RUN yum update -y && \
#     yum install -y wget

# RUN yum install -y java-11-openjdk-devel

# ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk

# RUN mkdir /opt/tomcat
# WORKDIR   /opt/tomcat
# ADD wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.11/bin/apache-tomcat-10.1.11.tar.gz  .
# RUN tar -xvzf apache-tomcat-10.1.11.tar.gz 
# RUN mv apache-tomcat-10.1.11.tar.gz/*  /opt/tomcat
# EXPOSE 9080
# COPY ./*.war  /opt/tomcat/webapps
# CMD  ["/opt/tomcat/bin/catlina.sh","run"]

FROM tomcat:8
COPY target/*.war /usr/local/tomcat/webapps/