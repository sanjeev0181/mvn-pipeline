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


FROM ubuntu:latest

# Update the package index and install necessary dependencies
RUN apt-get update && \
    apt-get install -y wget default-jdk

# Download and install Tomcat
RUN wget https://downloads.apache.org/tomcat/tomcat9/v9.0.54/bin/apache-tomcat-9.0.54.tar.gz && \
    tar -xvf apache-tomcat-9.0.54.tar.gz && \
    rm apache-tomcat-9.0.54.tar.gz

# Set the environment variables for Tomcat
ENV CATALINA_HOME=/apache-tomcat-9.0.54
ENV PATH=$CATALINA_HOME/bin:$PATH

# Copy the WAR file to the webapps directory
COPY target/*.war $CATALINA_HOME/webapps/

# Expose the default Tomcat port (8080)
EXPOSE 8063

# Start Tomcat when the container starts
CMD ["catalina.sh", "run"]
