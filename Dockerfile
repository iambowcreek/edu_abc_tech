# Official Tomcat runtime as a parent image
FROM tomcat:9.0.72-jdk11-corretto-al2

# Copy the .war file into the webapps directory
COPY **/*.war /usr/local/tomcat/webapps/

# Expose the default Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
