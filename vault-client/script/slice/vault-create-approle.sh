#!/bin/sh
approle=$(basename "$1")
policies=$(cat "$1")
ar=$(vault read auth/approle/role/$approle | grep Key | wc -c)
if [ $ar != 0 ]
then
	echo "Approle '$approle' already exists."
	exit 1;
fi
vault write auth/approle/role/$approle \
    token_num_uses=10 \
    policies=${policies}
vault read auth/approle/role/${approle}/role-id | grep role_id | cut -c 8- | xargs > $VAULT_SECRET_PATH/.${approle}_role_id
vault write -f auth/approle/role/${approle}/secret-id | grep 'secret_id ' | cut -c 10- | xargs > $VAULT_SECRET_PATH/.${approle}_secret_id