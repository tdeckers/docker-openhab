Overview
========

Docker image for Openhab (1.8.3). Included is JRE 1.8.45.


Official DEMO Included
========

If you do not have a openHAB configuration yet, you can start this Docker without one. The official openHAB DEMO will be started. 

PULL
=======
```docker pull tdeckers/openhab```

Building
========

```docker build -t <username>/openhab .```

Running
=======

* The image exposes openHAB ports 8080, 8443, 5555 and 9001 (supervisord).
* It expects you to map a configurations directory on the host to /etc/openhab. This allows you to inject your openhab configuration into the container (see example below).
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

* The openHAB process is managed using supervisord.  You can manage the process (and view logs) by exposing port 9001. From there it is possible to switch between NORMAL and DEBUG versions of OpenHAB runtime.
* The container supports starting without network (--net="none"), and adding network interfaces using pipework.
* You can add a timezone file in the configurations directory, which will be placed in /etc/timezone. Default: UTC

Example content for timezone:
```
Europe/Brussels
```

Example: run command (with your openHAB config)
```
docker run -d -p 8080:8080 -v /tmp/configuration:/etc/openhab/tdeckers/openhab
```


Example: Map configuration and logging directory as well as allow access to Supervisor:
```
docker run -d -p 8080:8080 -p 9001:9001 -v /tmp/configurations/:/etc/openhab -v /tmp/logs:/opt/openhab/logs tdeckers/openhab
```

Example: run command (with Demo)
```
docker run -d -p 8080:8080 tdeckers/openhab
```

Start the Demo with: 
```
http://[IP-of-Docker-Host]:8080/openhab.app?sitemap=demo
```
Access Supervisor with: 
```
http://[IP-of-Docker-Host]:9001
```


HABmin
=======

HABmin is not included in this deployment.  However you can easily add is as follows:
```
docker run -d -p 8080:8080 -v /<your_location>/webapps/habmin:/opt/openhab/webapps/habmin -v /<your_location>/openhab/config:/etc/openhab -v /<your_location>/openhab/addons-available/habmin:/opt/openhab/addons-available/habmin tdeckers/openhab
```

Then add these lines to addon.cfg
```
habmin/org.openhab.binding.zwave
habmin/org.openhab.io.habmin
```

Contributors
============
* maddingo
* scottt732
* TimWeyand
* dprus
* tdeckers
* wetware
* carlossg

