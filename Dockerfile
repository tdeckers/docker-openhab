# Openhab 1.8.2
# * configuration is injected
#
FROM java:openjdk-8-jdk
MAINTAINER Tom Deckers <tom@ducbase.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update \
  && apt-get -y upgrade \
  && apt-get -y install unzip supervisor wget

ENV OPENHAB_VERSION 1.8.2

#
# Download openHAB based on Environment OPENHAB_VERSION
#
COPY files/scripts/download_openhab.sh /root/
RUN /root/download_openhab.sh

COPY files/pipework /usr/local/bin/pipework
COPY files/supervisord.conf /etc/supervisor/supervisord.conf
COPY files/openhab.conf /etc/supervisor/conf.d/openhab.conf
COPY files/openhab_debug.conf /etc/supervisor/conf.d/openhab_debug.conf
COPY files/boot.sh /usr/local/bin/boot.sh
COPY files/openhab-restart /etc/network/if-up.d/openhab-restart

RUN mkdir -p /opt/openhab/logs

EXPOSE 8080 8443 5555 9001

CMD ["/usr/local/bin/boot.sh"]
