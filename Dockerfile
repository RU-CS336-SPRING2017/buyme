FROM tomcat:9.0.6-jre9
COPY buyme.war $CATALINA_HOME/webapps
COPY apache-tomcat-9.0.6/conf/server.xml $CATALINA_HOME/conf
COPY apache-tomcat-9.0.6/lib/mysql-connector-java-5.1.46.jar $CATALINA_HOME/lib
EXPOSE 8080
CMD ["catalina.sh", "run"]
