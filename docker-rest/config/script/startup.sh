#!/bin/sh
envsubst < /etc/confd/confd.toml.unprocessed > /etc/confd/confd.toml
for entry in /etc/confd/conf.d/*
do
	echo "Substituting environment variables for : "${entry}
    cat "${entry}" | while read line; do echo $(eval echo `echo $line`); done > ${entry%.*}
    envsubst < "${entry}" > "${entry%.*}"
done
echo "Calling confd on backend :" $CONFD_BACKEND
confd -onetime
echo "Starting Tomcat"
${CATALINA_HOME}/bin/catalina.sh run