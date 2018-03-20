FROM tomcat:9.0.6-jre9
ADD BuyMe.war $CATALINA_HOME/webapps
ADD apache-tomcat-9.0.6/conf/server.xml $CATALINA_HOME/conf
ADD apache-tomcat-9.0.6/lib/mysql-connector-java-5.1.46.jar $CATALINA_HOME/lib
EXPOSE 8080
CMD ["catalina.sh", "run"]
