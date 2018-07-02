#!/bin/sh
export VAULT_UNSEAL_KEY=$(cat $VAULT_SECRET_PATH/.vault_unseal_key)
export VAULT_TOKEN_KEY=$(cat $VAULT_SECRET_PATH/.vault_token)