# Openhab 1.8.3
# * configuration is injected
#
FROM openjdk:8-jre
MAINTAINER Tom Deckers <tom@ducbase.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update \
  && apt-get -y install unzip supervisor wget \
  && apt-get clean \
  && apt-get autoremove -y \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ARG OPENHAB_VERSION=1.8.3

#
# Download openHAB based on Environment OPENHAB_VERSION
#
COPY files/scripts/download_openhab.sh /root/
RUN /root/download_openhab.sh \
  && rm /root/download_openhab.sh

COPY files/pipework /usr/local/bin/pipework
COPY files/supervisord.conf /etc/supervisor/supervisord.conf
COPY files/openhab.conf /etc/supervisor/conf.d/openhab.conf
COPY files/openhab_debug.conf /etc/supervisor/conf.d/openhab_debug.conf
COPY files/boot.sh /usr/local/bin/boot.sh
COPY files/openhab-restart /etc/network/if-up.d/openhab-restart

EXPOSE 8080 8443 5555 9001

CMD ["/usr/local/bin/boot.sh"]
