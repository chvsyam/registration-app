FROM tomcat:latest

RUN cp -R /usr/local/tomcat/webapps.dist/* /usr/local/tomcat/webapps

# Adjusted to copy the .war file from the target directory
COPY ./target/*.war /usr/local/tomcat/webapps/




