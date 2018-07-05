#!/bin/sh
role_id_file="/vault/secret/.${CONFD_APPROLE}_role_id"
if [ -f "$role_id_file" ]
then
    echo "'${role_id_file}' found. Overriding environment variable value with file content"
    export CONFD_ROLE_ID=$(cat "${role_id_file}")
fi
secret_id_file="/vault/secret/.${CONFD_APPROLE}_secret_id"
if [ -f "$secret_id_file" ]
then
    echo "'${secret_id_file}' found. Overriding environment variable value with file content"
	export CONFD_SECRET_ID=$(cat "${secret_id_file}")
fi
echo "CONFD_ROLE_ID : '$CONFD_ROLE_ID'"
echo "CONFD_SECRET_ID : '$CONFD_SECRET_ID'"
echo "Substituting environment variables for : /etc/confd/confd.toml.unprocessed"
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