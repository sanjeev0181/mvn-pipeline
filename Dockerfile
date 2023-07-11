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


FROM centos:latest

# Install Java
RUN yum update -y && \
    yum install -y java-11-openjdk-devel

# Update repository configuration
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-Base.repo && \
    sed -i 's/#baseurl/baseurl/g' /etc/yum.repos.d/CentOS-Base.repo && \
    sed -i 's/mirror.centos.org/vault.centos.org/g' /etc/yum.repos.d/CentOS-Base.repo

# Download and extract Tomcat
RUN yum install -y wget && \
    wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.50/bin/apache-tomcat-9.0.50.tar.gz && \
    tar -xvf apache-tomcat-9.0.50.tar.gz && \
    mv apache-tomcat-9.0.50 /opt/tomcat

COPY target/*.war  /opt/tomcat/webapps

# Expose Tomcat port
EXPOSE 8088

# Start Tomcat
CMD ["/opt/tomcat/bin/catalina.sh", "run"]
