#!/bin/bash

# create an ord alias
touch /root/.bashrc
echo "alias ord='/ordinals/ord -r --cookie-file /bitcoin/.bitcoin/regtest/.cookie --rpc-url http://bitcoind:8332/ \$@'" >> /root/.bashrc

# create a new wallet, new recieving address, and mine 101 blocks to it
/ordinals/ord -r --cookie-file /bitcoin/.bitcoin/regtest/.cookie --rpc-url http://bitcoind:8332 wallet create
ADDRESS=$(/ordinals/ord -r --cookie-file /bitcoin/.bitcoin/regtest/.cookie --rpc-url http://bitcoind:8332 wallet receive 2>/dev/null | grep -o -E "\"address\": \"[^\"]+\"" | sed -E "s/\"address\": \"(.*)\"/\1/")
bitcoin-cli --rpcconnect=bitcoind --rpcport=8332 --rpccookiefile=/bitcoin/.bitcoin/regtest/.cookie generatetoaddress 101 $ADDRESS

# build ord index
/ordinals/ord -r --cookie-file /bitcoin/.bitcoin/regtest/.cookie --rpc-url http://bitcoind:8332 index

# make an inscription
/ordinals/ord -r --cookie-file /bitcoin/.bitcoin/regtest/.cookie --rpc-url http://bitcoind:8332 wallet inscribe /ordinals/dickbutt.jpg

# mine it
bitcoin-cli --rpcconnect=bitcoind --rpcport=8332 --rpccookiefile=/bitcoin/.bitcoin/regtest/.cookie generatetoaddress 1 $ADDRESS

# run the ord explorer server
# /ordinals/ord -r --cookie-file /bitcoin/.bitcoin/regtest/.cookie --rpc-url http://bitcoind:8332 server
read -p "Press any key to exit..."