# FROST-Server Helm chart

[Helm](https://helm.sh/) chart of the [FROST-Server](https://github.com/FraunhoferIOSB/FROST-Server) stack.

- [Requirements](#requirements)
- [Getting started](#getting-started)
    - [Deploy a FROST-Server stack](#deploy-a-frost-server-stack)
    - [Visualize deployed resources](#visualize-deployed-resources)
    - [Remove a FROST-Server stack deployment](#remove-a-frost-server-stack-deployment)
- [Configuration](#configuration)
    - [About MQTT support](#about-mqtt-support)
    - [About Ingress support](#about-ingress-support)
    - [About persistence support](#about-persistence-support)

## Requirements

- Have a [Kubernetes](https://kubernetes.io/) cluster. If you do not already have a cluster, you can create one by using [Minikube](https://kubernetes.io/docs/getting-started-guides/minikube), or you can use one of these Kubernetes playgrounds:
    - [Katacoda](https://www.katacoda.com/courses/kubernetes/playground)
    - [Play with Kubernetes](http://labs.play-with-k8s.com/) 
- Have the `kubectl` command-line tool must be configured to communicate with your cluster
- Have the [helm](https://helm.sh/) command-line tool [correctly initialized with your Kubernetes cluster](https://docs.helm.sh/using_helm/#quickstart-guide)
- (Optionally but recommended) Have a [Ingress controller](https://kubernetes.io/docs/concepts/services-networking/ingress/) installed on your Kubernetes cluster

## Getting started

### Deploy a FROST-Server stack

Declare the Helm repo or update it

    $ helm repo add storeconnect https://storeconnect.github.io/helm-charts
    $ helm repo update storeconnect
    
Install the FROST-Server chart

    $ helm install --name <release name> storeconnect/frost-server  

Where `<release name>` will be the name of the [Helm release](https://docs.helm.sh/using_helm/#quickstart-guide).

Once executed, this command creates a new FROST-Server Helm release reachable at the value of the `cluster.host` configuration key (`frost-server` by default).

_Note: By default, the `cluster.host` is defining a DNS name instead of an IP. Make sure to be able to resolve this DNS name by adding a rule either in your DNS server or in your local DNS resolver (e.g. `/etc/hosts` in Unix-based environments)._ 

### Visualize deployed resources

This Helm chart produces a fully operational [FROST-Server](http://www.opengeospatial.org/standards/sensorthings) stack composed of:
- A (or several, depending on the number of replicas) FROST-Server's HTTP service(s)
- A (or several, depending on the number of replicas) FROST-Server's MQTT service(s)
    - associated to an internal MQTT broker ([Eclipse Mosquitto](https://projects.eclipse.org/projects/technology.mosquitto))
- An internal FROST-Server's database
    - associated to a local volume (disabled by default but can be enabled as explained [here](#about-persistence-support))

To have a view about the Helm release status, execute:

    $ helm status <release name>
    
Where `<release name>` is the name of the Helm release.

To visualize logs about Helm release's pods, execute :

    $ kubeclt get pods -l release=<release name>
    $ kubeclt logs <pod name>
    
Where `<pod name>` is your desired pod name

Or, even simpler, by using [kubetail](https://github.com/johanhaleby/kubetail):

    $ kubetail -l release=<release name>
    
Where `<release name>` is the name of the Helm release. 

### Remove a FROST-Server stack deployment

To remove a FROST-Server stack deployment, more precisely the Helm release associated to this FROST-Server stack deployment, execute:

    $ helm delete <release name>

Where `<release name>` is the name of the Helm release.
    
## Configuration

As any Helm chart, the default configuration is defined in the associated [values.yaml](./values.yaml) file and can be overridden by either using the `--values` or `--set` `helm install|upgrade` option. For instance:

    $ helm install --values myvalues.yaml storeconnect/frost-server
    $ helm install --set ingress.enabled=true,frost.db.volume.enabled=true storeconnect/frost-server

### About MQTT support

As described in the [OGC SensorThings API specification](http://docs.opengeospatial.org/is/15-078r6/15-078r6.html#85), MQTT support is an optional extension but enabled by default in the FROST-Server Helm chart.
To disable MQTT support, override the `frost.mqtt.enabled` configuration value to `false`. 

    $ helm install --set frost.mqtt.enabled=false storeconnect/frost-server 

### About Ingress support

The FROST-Server chart can be installed with an [Ingress controller](https://kubernetes.io/docs/concepts/services-networking/ingress/). By default, Ingress is disabled but can be enabled thanks to the `ingress.enabled` option:

    $ helm install --set ingress.enabled=true storeconnect/frost-server
    
Or if you want to enable in your current Helm release:
    
    $ helm upgrade --set ingress.enabled=true <release name> storeconnect/frost-server
    
Where `<release name>` is the name of your current Helm release.
    
### About persistence support

By default, the FROST-Server chart is installed without permanent data persistence. Thus, if the Helm release or the `db` port is deleted, then all user data is lost.
You can enable permanent data persistence by using the `frost.db.volume.enabled` configuration key. For instance:

    $ helm install --set frost.db.volume.enabled=true storeconnect/frost-server

Once permanent data persistence is enabled, the FROST-Server chart will claim a [PersistentVolume](https://kubernetes.io/docs/concepts/storage/persistent-volumes/) that fits with its associated [StorageClass](https://kubernetes.io/docs/concepts/storage/storage-classes/) value.
By default, this value is set to `local` (thanks to the `frost.db.volume.storageClassName` configuration key) and bound to a [builtin local volume](./templates/db-local-volume.yaml) from within the cluster (defined by the `frost.db.volume.local.nodeMountPath` configuration key).

_Note: The default `local` StorageClass cannot be scaled._

To change this default behaviour, set the `frost.db.volume.storageClassName` to point to your desired StorageClass.