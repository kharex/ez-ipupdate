FROM debian:bullseye-slim

ENV IPLOOKUP_URI=http://ipinfo.io/ip \
    CONF_FILE=/var/cache/ez-ipupdate/ez.conf 

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get -q -y --no-install-recommends install ez-ipupdate curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/

CMD sh -c 'if [ ! -f $CONF_FILE ]; then echo "Please add config file"; exit 1; fi; \
           IPADDR=`curl -s $IPLOOKUP_URI`; \
           echo "`date --rfc-2822` ipaddr=$IPADDR"; \
           ez-ipupdate -c $CONF_FILE -a $IPADDR;'
