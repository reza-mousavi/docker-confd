#!/bin/sh
mkdir -p /home/vault
echo "Creating path : $VAULT_SECRET_PATH"
chmod a+rwx $VAULT_SECRET_PATH