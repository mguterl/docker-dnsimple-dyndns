FROM lsiobase/alpine
LABEL maintainer="Michael Guterl <michael@diminishing.org>"

RUN \
  echo '**** install packages ****' && \
  apk update && \
  apk add --no-cache dcron curl && \ 
  echo "**** cleanup ****" && \
  rm -rf \
    /root/.cache \
    /tmp/* \
    /var/cache/apk/* && \
  echo '**** setup cron ****' && \
  mkdir -p /var/log/cron && \
  mkdir -m 0644 -p /etc/cron.d && \
  touch /var/log/cron/cron.log

COPY /dnsimple.sh /etc/periodic/15min/dnsimple

# touch the dnsimple.log so that tail can follow it
# https://stackoverflow.com/a/43807880
CMD \
  crond -b -L /var/log/cron/cron.log "$@" && \
  touch /var/log/dnsimple.log && \
  tail -f /var/log/dnsimple.log
