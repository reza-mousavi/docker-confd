FROM tomcat:8.0-jre8
ARG CONFIG_FILE_LOCATION
ARG WAR_FILE
ARG PORT
#Installing wget
RUN apt-get update && apt-get install wget gettext -y
#Installing confd
RUN wget https://github.com/kelseyhightower/confd/releases/download/v0.16.0/confd-0.16.0-linux-amd64 --directory-prefix=/tmp \
		&& mkdir -p /opt/confd/bin \
		&& mv /tmp/confd-0.16.0-linux-amd64 /opt/confd/bin/confd \
		&& chmod +x /opt/confd/bin/confd
ENV PATH="${PATH}:/opt/confd/bin"
#Setting environment variables
ENV CATALINA_OPTS -Xms128m -Xmx1024m -server \
					-Dspring.profiles.active=docker \
					-Dspring.config.location=classpath:/config/application.properties,${CATALINA_HOME}/application.properties
RUN rm -rf ${CATALINA_HOME}/webapps/
ADD ${WAR_FILE} ${CATALINA_HOME}/webapps/ROOT.war
#Creating and moving templates
RUN bash -c 'mkdir -pv /etc/confd/{conf.d,templates}'
COPY config/confd/ /etc/confd/
COPY config/script/startup.sh /usr/local/bin/confd-tomcat-sartup.sh
RUN chmod a+x /usr/local/bin/confd-tomcat-sartup.sh
CMD ["/usr/local/bin/confd-tomcat-sartup.sh"]
EXPOSE ${PORT}