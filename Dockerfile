# Openhab 1.6.1
# * configuration is injected
FROM ubuntu
MAINTAINER Tim Weyand <tim.weyand@me.com>

# Download Openhab 1.6.1
ADD https://github.com/openhab/openhab/releases/download/v1.6.1/distribution-1.6.1-runtime.zip /tmp/distribution-runtime.zip
ADD https://github.com/openhab/openhab/releases/download/v1.6.1/distribution-1.6.1-addons.zip /tmp/distribution-addons.zip

# Install.
RUN \
  apt-get -y update && \
  apt-get -y upgrade && \
  apt-get -y install unzip supervisor wget

# Download and install Oracle JDK
# For direct download see: http://stackoverflow.com/questions/10268583/how-to-automate-download-and-installation-of-java-jdk-on-linux
RUN \
  wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" -O /tmp/jdk-7u67-linux-x64.tar.gz http://download.oracle.com/otn-pub/java/jdk/7u67-b01/jdk-7u67-linux-x64.tar.gz && \
  tar -zxC /opt -f /tmp/jdk-7u67-linux-x64.tar.gz && \
  ln -s /opt/jdk1.7.0_67 /opt/jdk7 && \
  echo 'PATH=$PATH:/opt/jdk7:/opt/jdk7/bin' >> /etc/environment && \
  echo 'export PATH' >> /etc/environment && \
  PATH=$PATH:/opt/jdk7:/opt/jdk7/bin && \
  export PATH


# Add pipework to wait for network if needed
ADD files/pipework /usr/local/bin/pipework
# Configure supervisor to run openhab
ADD files/supervisord.conf /etc/supervisor/supervisord.conf
ADD files/openhab.conf /etc/supervisor/conf.d/openhab.conf
ADD files/boot.sh /usr/local/bin/boot.sh
ADD files/openhab-restart /etc/network/if-up.d/openhab-restart


RUN \
  mkdir -p /opt/openhab/addons-available && \
  unzip -d /opt/openhab /tmp/distribution-runtime.zip && \
  unzip -d /opt/openhab/addons-available /tmp/distribution-addons.zip && \
  mv /opt/openhab/configurations /etc/openhab && \
  chmod +x /opt/openhab/start.sh && \
  mkdir -p /opt/openhab/logs && \
  chmod +x /usr/local/bin/pipework && \
  chmod +x /usr/local/bin/boot.sh && \
  chmod +x /etc/network/if-up.d/openhab-restart && \
  rm -rf /tmp/*

EXPOSE 8080 8443 5555 9001

CMD ["/usr/local/bin/boot.sh"]
