FROM tomcat:9.0.80-jre11-temurin-jammy@sha256:c3117850e025a347eb18b5bf259f2dcb805be1f8c19cabff810d7e322b407880

ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
RUN rm -rf $CATALINA_HOME/webapps/*

WORKDIR $CATALINA_HOME/webapps/ROOT


RUN echo '<html><body><h1>Hello my name is mohannad and this is my page hosted in tomcat server</h1></body></html>' > index.html


EXPOSE 8080

CMD ["catalina.sh", "run"]

