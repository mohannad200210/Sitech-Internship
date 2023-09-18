FROM mohannad200210/trytomee:latest@sha256:e4352205716372821cdb4a87101627329ba206a4a807499a3849ea4e04abd231

ENV TOMCAT_BASE=/usr/local/tomee

ADD *.war $TOMCAT_BASE/webapps/

EXPOSE 8080

CMD ["catalina.sh", "run"]
