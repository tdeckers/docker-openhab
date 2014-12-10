#!/bin/bash

wget --no-check-certificate --no-cookies -O /tmp/distribution-runtime.zip https://github.com/openhab/openhab/releases/download/v$OPENHAB_VERSION/distribution-$OPENHAB_VERSION-runtime.zip 
wget --no-check-certificate --no-cookies -O /tmp/distribution-addons.zip https://github.com/openhab/openhab/releases/download/v$OPENHAB_VERSION/distribution-$OPENHAB_VERSION-addons.zip
wget --no-check-certificate --no-cookies -O /tmp/demo-openhab.zip https://github.com/openhab/openhab/releases/download/v$OPENHAB_VERSION/distribution-$OPENHAB_VERSION-demo-configuration.zip
wget --no-check-certificate --no-cookies -O /tmp/org.openhab.io.myopenhab-1.4.0-SNAPSHOT.jar https://my.openhab.org/downloads/org.openhab.io.myopenhab-1.4.0-SNAPSHOT.jar

rm -rf /opt/openhab
mkdir -p /opt/openhab/addons-available
mkdir -p /opt/openhab/logs
unzip -d /opt/openhab /tmp/distribution-runtime.zip
unzip -d /opt/openhab/addons-available /tmp/distribution-addons.zip
unzip -d /opt/openhab/demo-configuration /tmp/demo-openhab.zip
chmod +x /opt/openhab/start.sh
mv /tmp/org.openhab.io.myopenhab-1.4.0-SNAPSHOT.jar /opt/openhab/addons-available
mv /opt/openhab/configurations /etc/openhab
ln -s /etc/openhab /opt/openhab/configurations
