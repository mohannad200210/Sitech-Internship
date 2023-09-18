FROM mohannad200210/trytomee

ENV TOMCAT_BASE=/usr/local/tomee

ADD *.war $TOMCAT_BASE/webapps/

EXPOSE 8080

CMD ["catalina.sh", "run"]
