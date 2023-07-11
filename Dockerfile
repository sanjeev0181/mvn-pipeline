FROM centos:latest
RUN yum install java -y 
RUN mkdir /opt/tomcat
WORKDIR   /opt/tomcat
ADD https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.11/bin/apache-tomcat-10.1.11.tar.gz  .
RUN tar -xvzf apache-tomcat-10.1.11.tar.gz 
RUN mv apache-tomcat-10.1.11.tar.gz/*  /opt/tomcat
EXPOSE 9080
COPY ./funds-1.0-SNAPSHOT.war  /opt/tomcat/webapps
CMD  ["/opt/tomcat/bin/catlina.sh","run"]