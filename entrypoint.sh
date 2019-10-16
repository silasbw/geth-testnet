#!/bin/sh

_UID=${ETHEREUM_UID:-1000}
_GID=${ETHEREUM_GID:-1000}

addgroup -g $_GID ethereum 
adduser -h /ethereum -D -G ethereum -u $_UID ethereum

su-exec ethereum "$@"
