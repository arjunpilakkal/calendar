# Ubuntu base
FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive

# Install Java + wget
RUN apt-get update \
 && apt-get install -y openjdk-11-jdk wget \
 && rm -rf /var/lib/apt/lists/*

# Install Apache Tomcat (working version)
RUN wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.108/bin/apache-tomcat-9.0.108.tar.gz \
 && tar xzf apache-tomcat-9.0.108.tar.gz \
 && mv apache-tomcat-9.0.108 /opt/tomcat \
 && rm apache-tomcat-9.0.108.tar.gz

# Add your WAR
COPY calendar.war /opt/tomcat/webapps/calendar.war

# Expose Tomcat port
EXPOSE 8080

# Run Tomcat in foreground
CMD ["/opt/tomcat/bin/catalina.sh", "run"]
