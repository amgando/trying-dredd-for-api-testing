#!/usr/bin/env sh

echo 
echo "make sure you install dredd first (npm i -g dredd)"
echo

# running dredd normally
dredd api-description.apib https://rpc.nearprotocol.com

# for debugging
# dredd -l debug api-description.apib https://rpc.nearprotocol.com