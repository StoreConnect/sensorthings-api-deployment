# FROST-Server Helm chart

[Kubernetes](https://kubernetes.io/) (with [Helm](https://helm.sh/)) deployment of a [FROST-Server](https://github.com/FraunhoferIOSB/FROST-Server) stack.

## Requirements

You need to have a Kubernetes cluster, and the `kubectl` command-line tool must be configured to communicate with your cluster. If you do not already have a cluster, you can create one by using [Minikube](https://kubernetes.io/docs/getting-started-guides/minikube), or you can use one of these Kubernetes playgrounds:
- [Katacoda](https://www.katacoda.com/courses/kubernetes/playground)
- [Play with Kubernetes](http://labs.play-with-k8s.com/)

You also need to have the [helm](https://helm.sh/) command-line tool [correctly initialized with your Kubernetes cluster](https://docs.helm.sh/using_helm/#quickstart-guide).

## Getting started

### Deploy a FROST-Server stack

    $ helm repo add storeconnect https://storeconnect.github.io/helm-charts
    $ helm install --set externalIp=<external ip> storeconnect/frost-server  

Where `<external ip>` is the IP of the target Kubernetes cluster.

Once executed, this command will create a new FROST-Server [Helm release](https://docs.helm.sh/using_helm/#quickstart-guide).

### Visualize deployed resources

This Helm chart produces a fully operational [FROST-Server](http://www.opengeospatial.org/standards/sensorthings) stack composed of:
- A (or several, depending on the number of replicas) FROST-Server's HTTP service(s)
- A FROST-Server's database
    - associated to a local volume (enabled by default but can be disabled as explained [here](#about-volume-configuration))
- A (or several, depending on the number of replicas) FROST-Server's MQTT service(s)
    - associated to an internal MQTT broker ([Eclipse Mosquitto](https://projects.eclipse.org/projects/technology.mosquitto))

To have a view about the Helm release status, execute:

    $ helm status <release name>
    
Where `<release name>` is the name of the Helm release

To visualize logs about Helm release's pods, execute :

    $ kubeclt get pods
    $ kubeclt logs frost-server-<pod suffix>
    
Where `<pod suffix>` is your desired pod's suffix

Or, even simpler, by using [kubetail](https://github.com/johanhaleby/kubetail):

    $ kubetail frost-server

### Remove a FROST-Server deployment

To remove a FROST-Server deployment, more precisely the Helm release associated to this FROST-Server deployment, execute

    $ helm delete <release name>

Where `<release name>` is the name of the Helm release.
    
## Access to FROST-Server's resources

Hereafter the list of available FROST-Server's resources when using the [default configuration values](./values.yaml):

FROST-Server's resource                             | Default access URL
--------------------------------------------------- | -----------------------
HTTP API                                            | `<Kubernetes cluster IP>/FROST-Server`
PostgreSQL (Postgis) database (TCP)                 | `<Kubernetes cluster IP>:5432`
PostgreSQL (Postgis) database (volume mount path)   | `<Kubernetes cluster IP>:/mnt/frost-server-db`
MQTT (TCP)                                          | `<Kubernetes cluster IP>:1883`
MQTT (Websocket)                                    | `<Kubernetes cluster IP>:9876`

Where `<Kubernetes cluster IP>` is obviously the target Kubernetes cluster IP (`externalIp` configuration value).
    
## Configuration

As any Helm chart, the default configuration is defined to the associated [values.yaml](./values.yaml) file and can be overridden by either using the `--values` or `--set` `helm install` option. For instance:

    $ helm install --values myvalues.yaml storeconnect/frost-server
    $ helm install --set externalIp=1.2.3.4,modules.http.replicas=4 storeconnect/frost-server

### About MQTT support

As described in the [OGC SensorThings API specification](http://docs.opengeospatial.org/is/15-078r6/15-078r6.html#85), the MQTT support is not mandatory but enabled by default in the FROST-Server Helm chart. To disable FROST-Server MQTT support, simply override set the `modules.mqtt.enabled` configuration value to `false`. 

    $ helm install --set externalIp=1.2.3.4,modules.mqtt.enabled=false storeconnect/frost-server 
    
### About volume configuration

The FROST-Server chart claims a [PersistentVolume](https://kubernetes.io/docs/concepts/storage/persistent-volumes/) that fits with its associated [StorageClass](https://kubernetes.io/docs/concepts/storage/storage-classes/) value.
By default, this value is set to `local` (thanks to the `.Values.modules.db.volume.storageClassName` configuration key) and bound to a [builtin local volume](./templates/db-local-volume.yaml).

To change this default behaviour, simply set the `.Values.modules.db.volume.storageClassName` to point to your desired StorageClass.