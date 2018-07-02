ARG VAULT_VERSION
FROM library/vault:${VAULT_VERSION}
COPY /config/vault.json /vault/config/vault.json
CMD ["vault", "server", "-config=/vault/config/vault.json"]
EXPOSE 8200