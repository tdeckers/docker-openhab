
# Openhab 1.6.0
# * configuration is injected
#
FROM ubuntu:14.04
MAINTAINER Tom Deckers <tom@ducbase.com>

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y install unzip supervisor wget

# Download and install Oracle JDK
# For direct download see: http://stackoverflow.com/questions/10268583/how-to-automate-download-and-installation-of-java-jdk-on-linux
RUN wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" -O /tmp/jdk-7u67-linux-x64.tar.gz http://download.oracle.com/otn-pub/java/jdk/7u67-b01/jdk-7u67-linux-x64.tar.gz
RUN tar -zxC /opt -f /tmp/jdk-7u67-linux-x64.tar.gz
RUN ln -s /opt/jdk1.7.0_67 /opt/jdk7

# Download Openhab 1.6.0
ADD https://github.com/openhab/openhab/releases/download/v1.6.0/distribution-1.6.0-runtime.zip /tmp/distribution-1.6.0-runtime.zip
ADD https://github.com/openhab/openhab/releases/download/v1.6.0/distribution-1.6.0-addons.zip /tmp/distribution-1.6.0-addons.zip

RUN mkdir -p /opt/openhab/addons-avail
RUN unzip -d /opt/openhab /tmp/distribution-1.6.0-runtime.zip
RUN unzip -d /opt/openhab/addons-avail /tmp/distribution-1.6.0-addons.zip
RUN chmod +x /opt/openhab/start.sh
RUN mkdir -p /opt/openhab/logs

ADD http://downloads.sourceforge.net/project/sigar/sigar/1.6/hyperic-sigar-1.6.4.tar.gz /tmp/hyperic-sigar-1.6.4.tar.gz
RUN mkdir -p /opt/openhab/lib
RUN tar -zxf /tmp/hyperic-sigar-1.6.4.tar.gz --wildcards --strip-components=2 -C /opt/openhab hyperic-sigar-1.6.4/sigar-bin/lib/*

# Add myopenhab 1.4.0 which works fine for openhab 1.6.0 (?)
ADD https://my.openhab.org/downloads/org.openhab.io.myopenhab-1.4.0-SNAPSHOT.jar /opt/openhab/addons-avail/org.openhab.io.myopenhab-1.4.0-SNAPSHOT.jar

# Add pipework to wait for network if needed
ADD files/pipework /usr/local/bin/pipework
RUN chmod +x /usr/local/bin/pipework

# Configure supervisor to run openhab
ADD files/supervisord.conf /etc/supervisor/supervisord.conf
ADD files/openhab.conf /etc/supervisor/conf.d/openhab.conf
ADD files/boot.sh /usr/local/bin/boot.sh
RUN chmod +x /usr/local/bin/boot.sh

# Restart openhab on network up.  Needed when starting with --net="none" to add network later.
ADD files/openhab-restart /etc/network/if-up.d/openhab-restart
RUN chmod +x /etc/network/if-up.d/openhab-restart

# Clean up
RUN rm -rf /tmp/*

EXPOSE 8080 8443 5555 9001

CMD ["/usr/local/bin/boot.sh"]
