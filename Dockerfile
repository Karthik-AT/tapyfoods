FROM tomcat:10.1-jdk17-temurin-jammy

# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WebContent folder to ROOT webapp
COPY WebContent /usr/local/tomcat/webapps/ROOT

# Copy compiled classes to ROOT webapp classes
COPY build/classes /usr/local/tomcat/webapps/ROOT/WEB-INF/classes

EXPOSE 8080
CMD ["catalina.sh", "run"]
