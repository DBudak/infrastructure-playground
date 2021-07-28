# k8s is a platform for running containers
# 2 main concepts of k8s API and cluster
# k8s cluster is a set of individual servers that have all been configured with container runtime like Docker
# Individual servers are called nodes
# each nnode is a VM
# each node can have multiple pods


# PODS

# a container is a vritualized environment that typically runs one app
# k8s wraps a container in another abstraction called pod
# pod is the basic computational unit in k8s that runs on a single node
# pod has its own virtual IP, managed by k8s
# pod can talk to other pods, even if they are on different nodes
# pod can run multiple containers, although usually they run only one

# CONTROLLERS

# a controller is a k8s resource that manages other resources
# works with k8s API to compare the irs state with cluster state and take actions if needed
# controller for pods is called Deployment

# SERVICES

# Services support routing traffic between pods, into pods, and outside to external systems
# Pods IP addresses are created and managed by k8s so they change every time controller respins them
# Service is an abstraction around that^ and provides a static ip address
# Load Balancer service routes outside traffic
# NodePort is like a load balancer for specific node, its implementation variaes by vendor so use Load Balancer
# External Name Service production service to resolve domain names to something that code expects
# above is useful for database connections but not HTTP communications which would require additional hacking to work

# HOW NETWORKING WORKS IN GENERAL
# ClusterIP is a virtual IP that does not exist on network
# Pods access network through kube proxy running on node
# kube proxy uses filtering to send virtual IP to real endpoint
# so service provide static IP that will resolve to pods it manages

# ENVIRONMENT VARIABLES

# Environment variables are static for the life of the pod
# cant be updated while the pod is running
# set in env: in manifests
# environment variables defined in env Pod spec overwrite env variables in envFrom or configMap

# CONFIG MAP

# config map is a resource that stores data that can be loaded into a pod
# data can be a file, text, an object etc
# one config map can be used by many pods
# k8s can use env files to create configMaps