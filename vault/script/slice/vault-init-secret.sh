#!/bin/sh
echo "Initializing secrets..."
emptyStr=""
basePath=$VAULT_DATA_PATH
for entry in $(find "$VAULT_DATA_PATH"/secret/json -type f )
do
#  echo "Applying secret :"${entry/$VAULT_DATA_PATH/emptyStr}
	echo "Writing path : "${entry}
    $VAULT_SCRIPT_PATH/slice/vault-create-secret.sh "${entry}"
done