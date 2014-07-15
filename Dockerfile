#
# Openhab 1.5.0
# * configuration is injected
# * addons:
#
FROM ubuntu:14.04
MAINTAINER Tom Deckers <tom@ducbase.com>

RUN apt-get -y update
RUN apt-get -y install openjdk-7-jre unzip

# Download Openhab 1.5.0
ADD https://github.com/openhab/openhab/releases/download/v1.5.0/distribution-1.5.0-runtime.zip /tmp/distribution-1.5.0-runtime.zip
ADD https://github.com/openhab/openhab/releases/download/v1.5.0/distribution-1.5.0-addons.zip /tmp/distribution-1.5.0-addons.zip

RUN mkdir -p /opt/openhab/addons-avail
RUN unzip -d /opt/openhab /tmp/distribution-1.5.0-runtime.zip
RUN unzip -d /opt/openhab/addons-avail /tmp/distribution-1.5.0-addons.zip
RUN chmod +x /opt/openhab/start.sh

# Add boot script
ADD files/boot.sh /usr/local/bin/boot.sh

EXPOSE 8080 8443

CMD /usr/local/bin/boot.sh
