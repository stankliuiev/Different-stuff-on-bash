#!/bin/bash
#monitoring of the blok number and time status
#by Varg  nksupport.com 2021.05.13

{ read blocknumb; read epochdate;} < <(wget -O- -q  http://172.16.130.2:8091/walletsolidity/getnowblock|jq '.block_header.raw_data.number,.block_header.raw_data.timestamp')

block_timestamp_epoch=$(expr $epochdate / 1000)
block_timestamp=$(date -d @$block_timestamp_epoch)
current_date=$(date '+%s')
time_latency=$(expr $current_date - $block_timestamp_epoch)
allowed_latency=200

if 
        [ "$time_latency" -lt "$allowed_latency" ]
then
    echo "the block number is $blocknumb time is $block_timestamp"
    exit 0
elif
        [ "$time_latency" -gt "$allowed_latency" ]
then
    echo "There is a CRITICAL time latency! $block_timestamp the block number is $blocknumb  "
    exit 1
fi
