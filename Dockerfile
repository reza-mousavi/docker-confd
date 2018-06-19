FROM library/nginx:1.15
ARG COMMAND_LINE_PARAM_ARG
RUN apt-get update
RUN apt-get install curl -y
RUN apt-get install wget -y
RUN cd /tmp
RUN wget https://github.com/kelseyhightower/confd/releases/download/v0.16.0/confd-0.16.0-linux-amd64
RUN mkdir -p /opt/confd/bin
RUN mv confd-0.16.0-linux-amd64 /opt/confd/bin/confd
RUN chmod +x /opt/confd/bin/confd
RUN export PATH="$PATH:"
ENV PATH="${PATH}:/opt/confd/bin"
RUN bash -c 'mkdir -pv /etc/confd/{conf.d,templates}'
COPY config/confd/toml/* /etc/confd/conf.d/
COPY config/confd/tmpl/* /etc/confd/templates/
ENV COMMAND_LINE_PARAM ${COMMAND_LINE_PARAM_ARG}
RUN confd -onetime -backend env
expose 80