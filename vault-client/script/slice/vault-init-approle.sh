#!/bin/sh
vault auth list | grep -q approle
ar=$(vault auth list |  grep approle | wc -c)
if [ $ar != 0 ]
then
	echo "App-role enabled"
	exit 1;
else
	echo "App-role not enabled"
fi
vault auth enable approle
sh $VAULT_SCRIPT_PATH/slice/vault-create-approle.sh read-config-approle read-config-policy