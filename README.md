# geth-testnet

Make it easy to run a local testnet for development.

## Running

Create a place to store the blockchain data and accounts:

```
CHAINDATA=...  # e.g., /home/sbw/testnet-chaindata
mkdir -p $CHAINDATA
```

Start container:

```
docker run --rm -ti \
  -p 8545:8545 \
  -v $CHAINDATA:/ethereum/chaindata \
  -e ETHEREUM_UID=$(id -u) \
  -e ETHEREUM_GID=$(id -g) \
  silasbw/geth-testnet:latest
```

If you want to reset your testnet:

```
rm -rf $CHAINDATA
docker run --rm -ti \
  -p 8545:8545 \
  -v $CHAINDATA:/ethereum/chaindata \
  -e ETHEREUM_UID=$(id -u) \
  -e ETHEREUM_GID=$(id -g) \
  silasbw/geth-testnet:latest
```

## Alternatives

[Truffle Ganache](http://truffleframework.com/ganache/) might be
easier to use, but has some open issues around supporting wallets
(e.g., <https://github.com/trufflesuite/ganache-cli/issues/236>).
