# mguterl/docker-dnsimple-dyndns

A docker container that updates a DNSimple DNS record with your current
public IP address.

## Usage

```sh
docker create --name=dyndns \
    -e TOKEN=<token> \
    -e ACCOUNT_ID=<account_id> \
    -e ZONE_ID=<zone_id> \
    -e RECORD_ID=<record_id> \
    mguterl/docker-dnsimple-dyndns
```

* `-e TOKEN` DNSimple API Token
* `-e ACCOUNT_ID` DNSimple Account ID
* `-e DOMAIN_NAME` DNSimple Domain
* `-e RECORD_ID` DNSimple record to update

## References

* https://developer.dnsimple.com/ddns/
* https://github.com/petemcw/docker-dnsimple-dyndns
* https://github.com/xordiv/docker-alpine-cron
