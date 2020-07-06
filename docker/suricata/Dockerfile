FROM alpine:latest
#
# Include dist
ADD dist/ /root/dist/
#
# Install packages
RUN sed -i 's/dl-cdn/dl-2/g' /etc/apk/repositories && \
    apk -U --no-cache add \
                 ca-certificates \
                 curl \
                 file \
                 libcap \
                 wget && \
    apk -U add --repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
                 suricata && \
#
# Setup user, groups and configs
    addgroup -g 2000 suri && \
    adduser -S -H -u 2000 -D -g 2000 suri && \
    chmod 644 /etc/suricata/*.config && \
    cp /root/dist/suricata.yaml /etc/suricata/suricata.yaml && \
    cp /root/dist/*.bpf /etc/suricata/ && \
#
# Download the latest EmergingThreats ruleset, replace rulebase and enable all rules
    cp /root/dist/update.sh /usr/bin/ && \
    chmod 755 /usr/bin/update.sh && \
    update.sh OPEN && \
#
# Clean up
    apk del --purge \
                 automake \
                 autoconf \
                 build-base \
                 cargo \
                 file-dev \
                 geoip-dev \
                 hiredis-dev \
                 jansson-dev \
                 libtool \
                 libhtp-dev \
                 libcap-ng-dev \
                 luajit-dev \
                 libpcap-dev \
		 libmaxminddb-dev \
                 libnet-dev \
                 libnetfilter_queue-dev \
                 libnfnetlink-dev \
                 lz4-dev \
                 nss-dev \
                 nspr-dev \
                 pcre-dev \
		 python3 \
                 rust \
                 yaml-dev && \
    rm -rf /opt/builder && \
    rm -rf /root/* && \
    rm -rf /tmp/* && \
    rm -rf /var/cache/apk/*
#
# Start suricata
STOPSIGNAL SIGINT
CMD SURICATA_CAPTURE_FILTER=$(update.sh $OINKCODE) && exec suricata -v -F $SURICATA_CAPTURE_FILTER -i $(/sbin/ip address | grep '^2: ' | awk '{ print $2 }' | tr -d [:punct:])
