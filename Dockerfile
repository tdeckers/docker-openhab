# Openhab 1.6.1
# * configuration is injected
FROM tweyand/ubuntu-base
MAINTAINER Tim Weyand <tim.weyand@me.com>

ENV OPENHAB_VERSION 1.6.1

# Install.
RUN apt-get install -y supervisor oracle-java8-installer

ADD files/* /root/docker-files/

# Download Openhab 1.6.1
ADD https://github.com/openhab/openhab/releases/download/v1.6.1/distribution-1.6.1-runtime.zip /tmp/distribution-runtime.zip
ADD https://github.com/openhab/openhab/releases/download/v1.6.1/distribution-1.6.1-addons.zip /tmp/distribution-addons.zip
ADD https://github.com/openhab/openhab/releases/download/v1.6.1/distribution-1.6.1-demo-configuration.zip /tmp/demo-openhab.zip
# Add my.openhab
ADD https://my.openhab.org/downloads/org.openhab.io.myopenhab-1.4.0-SNAPSHOT.jar /tmp/org.openhab.io.myopenhab-1.4.0-SNAPSHOT.jar

RUN \
  cp /root/docker-files/pipework /usr/local/bin/pipework && \
  cp /root/docker-files/supervisord.conf /etc/supervisor/supervisord.conf && \
  cp /root/docker-files/openhab.conf /etc/supervisor/conf.d/openhab.conf && \
  cp /root/docker-files/boot.sh /usr/local/bin/boot.sh && \
  cp /root/docker-files/openhab-restart /etc/network/if-up.d/openhab-restart

RUN \
  mkdir -p /opt/openhab/addons-available && \
  unzip -d /opt/openhab /tmp/distribution-runtime.zip && \
  unzip -d /opt/openhab/addons-available /tmp/distribution-addons.zip && \
  unzip -d /opt/openhab/demo-configuration /tmp/demo-openhab.zip && \
  mv /tmp/org.openhab.io.myopenhab-1.4.0-SNAPSHOT.jar /opt/openhab/addons-available && \
  mv /opt/openhab/configurations /etc/openhab && \
  ln -s /etc/openhab /opt/openhab/configurations && \
  chmod +x /opt/openhab/start.sh && \
  mkdir -p /opt/openhab/logs && \
  chmod +x /usr/local/bin/pipework && \
  chmod +x /usr/local/bin/boot.sh && \
  chmod +x /etc/network/if-up.d/openhab-restart && \
  rm -rf /tmp/*

RUN 

EXPOSE 8080 8443 5555 9001

CMD ["/usr/local/bin/boot.sh"]
