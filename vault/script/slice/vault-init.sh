#!/bin/sh
vault operator init -status
rc=$?
if [ $rc -eq 2 ]
then
  echo "Vault is not initialized."
elif [ $rc -eq 0 ]
then
  echo "Vault is initialized."
  exit 1
else [ $rc -eq 1 ]
  echo "An error occurred."
  exit 2
fi
echo "Initializing vault..."
vault operator init -format="table" -key-shares=1 -key-threshold=1 > $VAULT_SECRET_PATH/.keystore
#Unseal key
cat $VAULT_SECRET_PATH/.keystore | grep Unseal | cut -d\: -f2 | xargs > $VAULT_SECRET_PATH/.vault_unseal_key
#Vault token
cat $VAULT_SECRET_PATH/.keystore | grep Token | cut -d\: -f2 | xargs > $VAULT_SECRET_PATH/.vault_token