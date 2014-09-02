Overview
========

Docker image for Openhab.

Building
========

```docker build -t <username>/openhab```

Running
=======

* The image exposes Openhab ports 8080 and 8443.
* It expects you to make a configurations directory on the host to /opt/openhab/configurations.  This allows you to inject your openhab configuration into the container (see example below).
* To enable specific plugins, add a file with name addons.cfg in the configuration directory which lists all addons you want to add.
* 

Example content for addons.cfg:
```
org.openhab.action.mail-1.5.0.jar
org.openhab.action.squeezebox-1.5.0.jar
org.openhab.action.xmpp-1.5.0.jar
org.openhab.binding.exec-1.5.0.jar
org.openhab.binding.http-1.5.0.jar
org.openhab.binding.knx-1.5.0.jar
org.openhab.binding.mqtt-1.5.0.jar
org.openhab.binding.networkhealth-1.5.0.jar
org.openhab.binding.serial-1.5.0.jar
org.openhab.binding.squeezebox-1.5.0.jar
org.openhab.io.squeezeserver-1.5.0.jar
org.openhab.persistence.cosm-1.5.0.jar
org.openhab.persistence.db4o-1.5.0.jar
org.openhab.persistence.gcal-1.5.0.jar
org.openhab.persistence.rrd4j-1.5.0.jar
```

Example run command:
```docker -d -p 8080:8080 -v /tmp/configuration:/opt/openhab/configurations tdeckers/openhab```

