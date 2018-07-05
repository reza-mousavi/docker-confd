FROM library/nginx:1.15
#Setting input parameters as environemnt variables
ARG PORT
ARG COMMAND_LINE_PARAM_ARG
ENV COMMAND_LINE_PARAM ${COMMAND_LINE_PARAM_ARG}
#Installing wget, gettext
RUN apt-get update && apt-get install wget gettext -y
#Installing confd
RUN wget https://github.com/kelseyhightower/confd/releases/download/v0.16.0/confd-0.16.0-linux-amd64 --directory-prefix=/tmp \
		&& mkdir -p /opt/confd/bin \
		&& mv /tmp/confd-0.16.0-linux-amd64 /opt/confd/bin/confd \
		&& chmod +x /opt/confd/bin/confd
ENV PATH="${PATH}:/opt/confd/bin"
#Creating and moving templates
RUN bash -c 'mkdir -pv /etc/confd/{conf.d,templates}'
COPY config/confd/ /etc/confd/
COPY config/script/startup.sh /usr/local/bin/confd-nginx-sartup.sh
RUN chmod a+x /usr/local/bin/confd-nginx-sartup.sh
CMD ["/usr/local/bin/confd-nginx-sartup.sh"]
EXPOSE ${PORT}