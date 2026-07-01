FROM tomcat:10.1-jdk17-temurin-jammy

# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Create directory for compiled classes
RUN mkdir -p /usr/local/tomcat/webapps/ROOT/WEB-INF/classes

# Copy WebContent static pages and libraries
COPY WebContent /usr/local/tomcat/webapps/ROOT

# Copy the Java source files
COPY src /tmp/src

# Compile Java classes inside the container during build
RUN find /tmp/src -name "*.java" > /tmp/sources.txt && \
    javac -d /usr/local/tomcat/webapps/ROOT/WEB-INF/classes \
          -classpath "/usr/local/tomcat/lib/*:/usr/local/tomcat/webapps/ROOT/WEB-INF/lib/*" \
          @/tmp/sources.txt && \
    rm -rf /tmp/src /tmp/sources.txt

EXPOSE 8080
CMD ["catalina.sh", "run"]
