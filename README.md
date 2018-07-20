# SensorThings API stack deployment

A ready to deploy & use [SensorThings API](https://github.com/opengeospatial/sensorthings) stack with additional extra features.

## Features

Feature                                             | Description                                                   | Status
--------------------------------------------------- | ------------------------------------------------------------- | ----------------
["One-click" deployment](#one-click-deployment)     | Fully configurable deployment of the SensorThings API stack   | Work in progress
[(Extra) API access control](#api-access-control)   | Control the access to the SensorThings API                    | To Do
[(Extra) Metrics](#metrics)                         | Metrics about the SensorThings API usage                      | To do

### "One-click" deployment

#### Description

Fully configurable deployment of the SensorThings API stack, that can be easily deployed in "one click".

This stack is using:
- [FROST-Server](https://github.com/FraunhoferIOSB/FROST-Server) as implementation of the SensorThings API specification.
- [Kubernetes](https://kubernetes.io/) and [Rancher](https://rancher.com/) as container orchestrators
- [Ansible](https://www.ansible.com/) as deployment automation tool

It is not necessary to use the fully version of the stack. Any technology-related configuration can be used independently to fit to your needs. Example: you can only use the Kubernetes configuration if you only want to have a Kubernetes deployment of a SensorThings API instance.  

#### Sources

Configuration   | Description                                                                               | Source access
--------------- | ----------------------------------------------------------------------------------------- | -----------
Kubernetes      | Kubernetes deployment of a SensorThings API stack                                         | [Source](./deployment/kubernetes)
Rancher         | Rancher deployment of a SensorThings API stack (using Kubernetes deployment)              | To do
Ansible         | Ansible deployment of a SensorThings API stack (using Kubernetes & Rancher deployments)   | To do
 
### API access control

#### Description

The SensorThings API definition does not define a way to protect the access of the data. This need can be addressed by using an API Management solution.

#### Sources

To do

### Metrics

#### Description

Metrics about the SensorThings API usage.

#### Sources

To do 

## Contribution

Contributions are welcome :-) To do so, check out the [instructions](./CONTRIBUTING.md).