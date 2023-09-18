FROM tomee:9.1-jre11-Semeru-webprofile@sha256:da63ad7ebcdb6ccd1575ad20d3fc0e620f7cb8cd55069c229879e1831a444769

# ENV TOMCAT_BASE=/usr/local/tomee

ADD *.war $TOMCAT_BASE/webapps/

EXPOSE 8080

CMD ["catalina.sh", "run"]
