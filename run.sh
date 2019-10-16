#!/bin/sh

set -e
set -x

DATADIR=/ethereum/chaindata

echo -n 12345679 > /ethereum/password.txt

if [ ! -f $DATADIR/etherbase ]; then
    rm -rf $DATADIR/*

    mkdir $DATADIR/ethash
    ln -s $DATADIR/ethash ~/.ethash
    
    ACCOUNT0=$(geth --datadir=$DATADIR account new --password=/ethereum/password.txt | sed -e 's/Address: {\(.*\)}/\1/g')
    ACCOUNT1=$(geth --datadir=$DATADIR account new --password=/ethereum/password.txt | sed -e 's/Address: {\(.*\)}/\1/g')
    ACCOUNT2=$(geth --datadir=$DATADIR account new --password=/ethereum/password.txt | sed -e 's/Address: {\(.*\)}/\1/g')

    cat /genesis.tmpl | \
        sed -e "s/ACCOUNT0/$ACCOUNT0/g" | \
        sed -e "s/ACCOUNT1/$ACCOUNT1/g" | \
        sed -e "s/ACCOUNT2/$ACCOUNT2/g" > $DATADIR/genesis.json

    geth --datadir=$DATADIR init $DATADIR/genesis.json

    echo $ACCOUNT0 > $DATADIR/etherbase
else
    ln -s $DATADIR/ethash ~/.ethash
fi

ETHERBASE=$(cat $DATADIR/etherbase)
geth --password=/ethereum/password.txt --unlock="0,1,2" --mine --minerthreads=1 --datadir=$DATADIR --etherbase=$ETHERBASE --rpc --rpcaddr 0.0.0.0 --rpcapi db,eth,net,web3,personal
