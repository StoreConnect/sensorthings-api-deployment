# SensorThings API Kubernetes deployment

Kubernetes deployment of a [SensorThings API](http://www.opengeospatial.org/standards/sensorthings) stack, using the [FROST-Server](https://github.com/FraunhoferIOSB/FROST-Server) as SensorThings API (Sensing) implementation.

## Requirements

You need to have a Kubernetes cluster, and the `kubectl` command-line tool must be configured to communicate with your cluster. If you do not already have a cluster, you can create one by using [Minikube](https://kubernetes.io/docs/getting-started-guides/minikube), or you can use one of these Kubernetes playgrounds:
- [Katacoda](https://www.katacoda.com/courses/kubernetes/playground)
- [Play with Kubernetes](http://labs.play-with-k8s.com/)

You also need to have the [kubetpl](https://github.com/shyiko/kubetpl) command-line tool to be able to parse template files.

## Getting started

This Kubernetes deployment produces a fully operational [FROST-Server](http://www.opengeospatial.org/standards/sensorthings) stack, using the [FROST-Server](https://github.com/FraunhoferIOSB/FROST-Server) instance with the following main components:
- FROST-Server's HTTP service
- FROST-Server's database
    - associated to a local volume
- FROST-Server's MQTT service

To start or update a SensorThings API Kubernetes deployment, execute:

    $ ./frost.sh --start
    
Once deployment is started, you can visualize its associated resources (services, pods, volumes, volume claims and secrets) via:

    $ kubectl get svc,pods,pv,pvc,secrets
    
By default, any SensorThings API Kubernetes's resource is prefixed by `frost-`

To stop a SensorThings API Kubernetes deployment (and delete any Kubernetes resources), execute:

    $ ./frost.sh --stop
    
## Configuration

SensorThings API Kubernetes deployment is done by rendering `*.template.yml` template files. Configuration of these templates can be done within the [frost-properties.yml](./frost-properties.yml) file.