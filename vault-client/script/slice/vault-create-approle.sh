#!/bin/sh
ar=$(vault read auth/approle/role/$1 | grep Key | wc -c)
if [ $ar != 0 ]
then
	echo "Approle '$1' already exists."
	exit 1;
fi
vault write auth/approle/role/$1 \
    token_num_uses=10 \
    policies=$2
vault read auth/approle/role/$1/role-id | grep role_id | cut -c 8- | xargs > $VAULT_SECRET_PATH/.$1_role_id
vault write -f auth/approle/role/$1/secret-id | grep 'secret_id ' | cut -c 10- | xargs > $VAULT_SECRET_PATH/.$1_secret_id