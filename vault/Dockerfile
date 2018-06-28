FROM library/vault:0.10.2
ARG COMMAND_LINE_PARAM_ARG
COPY /config/vault.json /vault/config/vault.json
RUN mkdir -p /vault/init/custom
COPY /script/config.sh /vault/init/custom/config.sh
RUN chmod +x /vault/init/custom/config.sh
CMD ["vault", "server", "-config=/vault/config/vault.json"]
EXPOSE 8200