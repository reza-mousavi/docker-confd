FROM library/nginx:1.15
#Setting input parameters as environemnt variables
ARG COMMAND_LINE_PARAM_ARG
ARG CONFD_BACKEND_ARG
ENV COMMAND_LINE_PARAM ${COMMAND_LINE_PARAM_ARG}
ENV CONFD_BACKEND ${CONFD_BACKEND_ARG}
#Installing wget
RUN apt-get update
RUN apt-get install wget -y
#Installing confd
RUN cd /tmp
RUN wget https://github.com/kelseyhightower/confd/releases/download/v0.16.0/confd-0.16.0-linux-amd64
RUN mkdir -p /opt/confd/bin
RUN mv confd-0.16.0-linux-amd64 /opt/confd/bin/confd
RUN chmod +x /opt/confd/bin/confd
ENV PATH="${PATH}:/opt/confd/bin"
#Creating and moving templates
RUN bash -c 'mkdir -pv /etc/confd/{conf.d,templates}'
COPY config/confd/ /etc/confd/
COPY config/script/startup.sh /usr/local/bin/confd-nginx-sartup.sh
RUN chmod a+x /usr/local/bin/confd-nginx-sartup.sh
#CMD ["nginx", "-g", "daemon off;"]
CMD ["/usr/local/bin/confd-nginx-sartup.sh"]
EXPOSE 80