Overview
========

Docker image for openHAB (1.6.1).


Official DEMO Included
========

If you do not have a openHAB configuration yet, you can start this Docker without one. The official openHAB DEMO will be started. 

PULL
=======
```docker pull tweyand/openhab```

or

Building
========

```docker build -t <username>/openhab```

Running
=======

* The image exposes openHAB ports 8080, 8443, 5555 and 9001 (supervisord).
* It expects you to make a configurations directory on the host to /etc/openhab.  This allows you to inject your openhab configuration into the container (see example below).
* To enable specific plugins, add a file with name addons.cfg in the configuration directory which lists all addons you want to add.

Example content for addons.cfg:
```
org.openhab.action.mail
org.openhab.action.squeezebox
org.openhab.action.xmpp
org.openhab.binding.exec
org.openhab.binding.http
org.openhab.binding.knx
org.openhab.binding.mqtt
org.openhab.binding.networkhealth
org.openhab.binding.serial
org.openhab.binding.squeezebox
org.openhab.io.squeezeserver
org.openhab.persistence.cosm
org.openhab.persistence.db4o
org.openhab.persistence.gcal
org.openhab.persistence.rrd4j
```

* The openHAB process is managed using supervisord.  You can manage the process (and view logs) by exposing port 9001.
* The container supports starting without network (--net="none"), and adding network interfaces using pipework.
* You can add a timezone file in the configurations directory, which will be placed in /etc/timezone. Default: UTC

Example content for timezone:
```
Europe/Brussels
```

Example run command (with your openHAB config)
```docker -d -p 8080:8080 -v /tmp/configuration:/etc/openhab/ tweyand/openhab```

Example run command (with Demo)
```docker -d -p 8080:8080 tweyand/openhab```

Start the Demo with: ```http://[IP-of-Docker-Host]:8080/openhab.app?sitemap=demo```
