#!/bin/sh
echo "Calling backend :" $CONFD_BACKEND
/opt/confd/bin/confd -onetime -node $CONFD_BACKEND -role-id $CONFD_ROLE_ID -secret-id $CONFD_SECRET_ID
echo "Starting Nginx"
/usr/sbin/nginx -g "daemon off;"