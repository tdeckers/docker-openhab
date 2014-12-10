# Openhab 1.6.1
# * configuration is injected
FROM tweyand/ubuntu-base
MAINTAINER Tim Weyand <tim.weyand@me.com>

ENV OPENHAB_VERSION 1.6.1

# Install.
RUN apt-get install -y supervisor oracle-java8-installer

ADD files /root/docker-files/

RUN \
  cp /root/docker-files/pipework /usr/local/bin/pipework && \
  cp /root/docker-files/supervisord.conf /etc/supervisor/supervisord.conf && \
  cp /root/docker-files/openhab.conf /etc/supervisor/conf.d/openhab.conf && \
  cp /root/docker-files/boot.sh /usr/local/bin/boot.sh && \
  cp /root/docker-files/openhab-restart /etc/network/if-up.d/openhab-restart && \
  mkdir -p /opt/openhab/logs && \
  chmod +x /usr/local/bin/pipework && \
  chmod +x /usr/local/bin/boot.sh && \
  chmod +x /etc/network/if-up.d/openhab-restart && \
  rm -rf /tmp/*

#
# Download openHAB based on Environment OPENHAB_VERSION
#
RUN \
  chmod +x /root/docker-files/scripts/download_openhab.sh  && \
  /root/docker-files/scripts/download_openhab.sh

EXPOSE 8080 8443 5555 9001

CMD ["/usr/local/bin/boot.sh"]
