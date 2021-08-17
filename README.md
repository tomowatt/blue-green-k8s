# Blue/Green Deployments on Kubernetes

## About

An prototype implementation of using Terraform to provide Blue/Green Deployments on Kubernetes.
Using two Ingresses serving on different Domains, with one of them 'hidden' behind Basic Authentication.

Switching between the two Deployments would be done at the Ingress, from Blue Service to Green Service and vice versa. But this could be changed to different Paths or using HTTP Headers to route to the different 'versions'.
Separate ConfigMaps allows for updating the 'versions' individually.

Different Namespaces could be used, but adds extra complexity when switching the Ingress Backend, creating two 'environments' rather than 'versions'.

Abstracting with Variables allows for a more declarative approach and moves the configuration changes into a centralised file but not done for demonstration purposes.

## Application Code

A Go HTTP server that templates HTML.

[blue-green](https://github.com/tomowatt/blue-green)
