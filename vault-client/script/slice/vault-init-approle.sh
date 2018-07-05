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
for entry in $(find "$VAULT_DATA_PATH"/approle -type f )
do
	echo "Writing approle : "${entry}
    $VAULT_SCRIPT_PATH/slice/vault-create-approle.sh "${entry}"
done
