FROM java:9-jdk AS jdk
ADD BuyMe/ build
RUN jar -cvf BuyMe.war build

FROM tomcat:9.0.6-jre9
COPY --from=jdk BuyMe.war $CATALINA_HOME/webapps
EXPOSE 8080
CMD ["catalina.sh", "run"]
