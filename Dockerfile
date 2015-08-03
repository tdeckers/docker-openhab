# Openhab 1.6.2
# * configuration is injected
#
FROM java:openjdk-7u79-jdk
MAINTAINER Tom Deckers <tom@ducbase.com>

RUN apt-get update && apt-get -y upgrade && apt-get -y install unzip supervisor wget

ENV OPENHAB_VERSION 1.7.0

#
# Download openHAB based on Environment OPENHAB_VERSION
#
COPY files/scripts/download_openhab.sh /root/
RUN /root/download_openhab.sh

COPY files/pipework /usr/local/bin/pipework
COPY files/supervisord.conf /etc/supervisor/supervisord.conf
COPY files/openhab.conf /etc/supervisor/conf.d/openhab.conf
COPY files/boot.sh /usr/local/bin/boot.sh
COPY files/openhab-restart /etc/network/if-up.d/openhab-restart

RUN mkdir -p /opt/openhab/logs

EXPOSE 8080 8443 5555 9001

CMD ["/usr/local/bin/boot.sh"]
