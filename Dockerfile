# Openhab 1.7.0
# * configuration is injected
#
FROM ubuntu:14.04
MAINTAINER Marcus of Wetware Labs <marcus@wetwa.re>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y install unzip supervisor wget

# Download and install Oracle JDK
# For direct download see: http://stackoverflow.com/questions/10268583/how-to-automate-download-and-installation-of-java-jdk-on-linux
RUN wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" -O /tmp/jre-8u45-linux-x64.tar.gz http://download.oracle.com/otn-pub/java/jdk/8u45-b14/jre-8u45-linux-x64.tar.gz
RUN tar -zxC /opt -f /tmp/jre-8u45-linux-x64.tar.gz
RUN ln -s /opt/jre1.8.0_45 /opt/jre8

ENV OPENHAB_VERSION 1.7.0

ADD files /root/docker-files/

RUN \
  chmod +x /root/docker-files/scripts/download_openhab.sh  && \
  cp /root/docker-files/pipework /usr/local/bin/pipework && \
  cp /root/docker-files/supervisord.conf /etc/supervisor/supervisord.conf && \
  cp /root/docker-files/openhab.conf /etc/supervisor/conf.d/openhab.conf && \
  cp /root/docker-files/openhab_debug.conf /etc/supervisor/conf.d/openhab_debug.conf && \
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
RUN /root/docker-files/scripts/download_openhab.sh

EXPOSE 8080 8443 5555 9001

ENV PATH /opt/jre8/bin:$PATH

CMD ["/usr/local/bin/boot.sh"]
