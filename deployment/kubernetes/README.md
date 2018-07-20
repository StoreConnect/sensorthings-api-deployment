# SensorThings API Kubernetes deployment

Kubernetes deployment of a [SensorThings API](http://www.opengeospatial.org/standards/sensorthings) stack, using the [FROST-Server](https://github.com/FraunhoferIOSB/FROST-Server) as SensorThings API (Sensing) implementation.

## Requirements

You need to have a Kubernetes cluster, and the `kubectl` command-line tool must be configured to communicate with your cluster. If you do not already have a cluster, you can create one by using [Minikube](https://kubernetes.io/docs/getting-started-guides/minikube), or you can use one of these Kubernetes playgrounds:
- [Katacoda](https://www.katacoda.com/courses/kubernetes/playground)
- [Play with Kubernetes](http://labs.play-with-k8s.com/)

You also need to have the [kubetpl](https://github.com/shyiko/kubetpl) command-line tool to be able to parse template files.

## Getting started

### Start/Logs/Stop

This Kubernetes deployment produces a fully operational [FROST-Server](http://www.opengeospatial.org/standards/sensorthings) stack, using the [FROST-Server](https://github.com/FraunhoferIOSB/FROST-Server) instance with the following main components:
- FROST-Server's HTTP service
- FROST-Server's database
    - associated to a local volume
- FROST-Server's MQTT service
    - associated to an internal MQTT broker ([Eclipse Mosquitto](https://projects.eclipse.org/projects/technology.mosquitto))

To start or update a SensorThings API Kubernetes deployment, execute:

    $ ./frost.sh --start
    
Once deployment is started, you can visualize its associated resources (services, pods, volumes, volume claims and secrets) via:

    $ kubectl get svc,pods,pv,pvc,secrets
    
_Note: By default, any SensorThings API Kubernetes's resource is prefixed by `frost-`_

Or, even simpler, by using [kubetail](https://github.com/johanhaleby/kubetail) and execute:

    $ kubetail frost

To stop a SensorThings API Kubernetes deployment (and delete any Kubernetes resources), execute:

    $ ./frost.sh --stop
    
### Access to FROST-Server's resources

Hereafter the list of available FROST-Server's resources when deploying the default Kubernetes configuration

FROST-Server's resource         | Default access URL
------------------------------- | -----------------------
HTTP API                        | `<Kubernetes cluster IP>:8080/FROST-Server`
PostgreSQL (Postgis) database   | `<Kubernetes cluster IP>:5432`
MQTT TCP                        | `<Kubernetes cluster IP>:1883`
MQTT Websocket                  | `<Kubernetes cluster IP>:9876`
    
## Configuration

SensorThings API Kubernetes deployment is done by rendering `*.template.yml` template files based on the [frost-properties.yml](./frost-properties.yml) configuration file. This way, you only have to edit this file to create a SensorThings API Kubernetes deployment that fits to your need.