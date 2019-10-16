FROM ethereum/client-go:v1.8.6

RUN apk add --no-cache su-exec shadow

COPY run.sh entrypoint.sh /

RUN mkdir /ethereum
COPY genesis.tmpl /

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/run.sh"]
