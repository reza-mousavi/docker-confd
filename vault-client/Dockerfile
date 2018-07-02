ARG VAULT_VERSION_ARG
FROM library/vault:${VAULT_VERSION_ARG}
ARG VAULT_URL_ARG
ENV VAULT_ADDR=${VAULT_URL_ARG}
RUN mkdir -p /vault/client/script
RUN mkdir -p /vault/client/data
RUN mkdir -p /vault/client/secret
COPY /script/ /vault/client/script/
COPY /data/ /vault/client/data/
WORKDIR /vault/client/script
RUN chmod a+x config.sh
RUN chmod a+x ./slice/*
CMD ["/vault/client/script/config.sh"]