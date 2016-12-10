# Openhab 1.8.3
# * configuration is injected
#
FROM ubuntu:16.04
MAINTAINER Tom Deckers <tom@ducbase.com>

ENV OPENHAB_VERSION 1.8.3
ENV DEBIAN_FRONTEND noninteractive

RUN  apt-get -y update \
  && apt-get -y install software-properties-common \
  && echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections \
  && apt-add-repository ppa:webupd8team/java \
  && apt-get -y update \
  && apt-get -y install unzip supervisor wget \
  && apt-get -y install oracle-java8-installer oracle-java8-set-default \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && rm -rf /var/cache/oracle-jdk8-installer

#
# Download openHAB based on Environment OPENHAB_VERSION
#
COPY files/scripts/download_openhab.sh /root/
RUN /root/download_openhab.sh

COPY files/supervisord.conf /etc/supervisor/supervisord.conf
COPY files/openhab.conf /etc/supervisor/conf.d/openhab.conf
COPY files/openhab_debug.conf /etc/supervisor/conf.d/openhab_debug.conf
COPY files/boot.sh /usr/local/bin/boot.sh
COPY files/openhab.sh /usr/local/bin/openhab.sh
COPY files/openhab-restart /etc/network/if-up.d/openhab-restart

RUN mkdir -p /opt/openhab/logs

EXPOSE 8080 8443 5555 9001

CMD ["/usr/local/bin/boot.sh"]
