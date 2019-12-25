#!/bin/bash

set -e

# TOKEN - API v2 OAuth token
# ACCOUNT_ID - Account ID
# ZONE_ID - Zone ID is the name of the zone (or domain)
# RECORD_ID - DNS record ID

if [[ -z $TOKEN ]]; then
    echo "TOKEN is required"
    exit 1
fi

if [[ -z $ACCOUNT_ID ]]; then
    echo "ACCOUNT_ID is required"
    exit 1
fi

if [[ -z $ZONE_ID ]]; then
    echo "ZONE_ID is required"
    exit 1
fi

if [[ -z $RECORD_ID ]]; then
    echo "RECORD_ID is required"
    exit 1
fi

echo "$(date) Fetching IP address" >> /var/log/dnsimple.log
IP=`curl --ipv4 -s http://icanhazip.com/`

if ! [[ $IP =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "Invalid IP address received: $IP"
    exit 2
fi

echo "$(date) Updating DNSimple $ZONE_ID with IP address: $IP" >> /var/log/dnsimple.log

curl -H "Authorization: Bearer $TOKEN" \
     -H "Content-Type: application/json" \
     -H "Accept: application/json" \
     -X "PATCH" \
     -i "https://api.dnsimple.com/v2/$ACCOUNT_ID/zones/$ZONE_ID/records/$RECORD_ID" \
     -d "{\"content\":\"$IP\"}"
