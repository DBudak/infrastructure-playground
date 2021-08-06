# K8s is a platform for running containers
# 2 main concepts of k8s API and cluster
# K8s cluster is a set of individual servers that have all been configured with container runtime like Docker
# Individual servers are called nodes
# Each nnode is a VM
# Each node can have multiple pods


# PODS

# A container is a vritualized environment that typically runs one app
# K8s wraps a container in another abstraction called pod
# Pod is the basic computational unit in k8s that runs on a single node
# Pod has its own virtual IP, managed by k8s
# Pod can talk to other pods, even if they are on different nodes
# Pod can run multiple containers, although usually they run only one
# Pod name contains a hash with deployment template

# CONTROLLERS

# A controller is a k8s resource that manages other resources
# Works with k8s API to compare the irs state with cluster state and take actions if needed
# Controller for pods is called Deployment

# SERVICES

# Services support routing traffic between pods, into pods, and outside to external systems
# Pods IP addresses are created and managed by k8s so they change every time controller respins them
# Service is an abstraction around that^ and provides a static ip address
# Load Balancer service routes outside traffic
# NodePort is like a load balancer for specific node, its implementation variaes by vendor so use Load Balancer
# External Name Service production service to resolve domain names to something that code expects
# Above is useful for database connections but not HTTP communications which would require additional hacking to work

# HOW NETWORKING WORKS IN GENERAL

# ClusterIP is a virtual IP that does not exist on network
# Pods access network through kube proxy running on node
# Kube proxy uses filtering to send virtual IP to real endpoint
# So service provide static IP that will resolve to pods it manages

# ENVIRONMENT VARIABLES

# Environment variables are static for the life of the pod
# Cant be updated while the pod is running
# Set in env: in manifests
# Environment variables defined in env Pod spec overwrite env variables in envFrom or configMap

# CONFIG MAP

# Config map is a resource that stores data that can be loaded into a pod
# Data can be a file, text, an object etc
# One config map can be used by many pods
# K8s can use env files to create configMaps

# SECRETS

# Same API as ConfigMaps
# Stored in memory instead of on disk
# Sent only to nodes that need them
# K8s supports encryption in transit and at rest for Secrets

# VOLUMES

# Volume is the unit in k8s for data storage
# Volume by default exists on a Pod so has the same lifecycle
# Volume can define a disk storage, network storage etco
# Next level after pod is Node volume
# Node valume has lifecycle of a node it is hosted in
# Node volume type is HostPath
# HostPath limits: if replacement Pod starts on a new node it won't have access to data
# Never give direct access to / always define subpaths
# HostPath don't make sense in a cluster with more than one node because of the above

# PERSISTENT VOLUMES (PV) AND PERSISTENT VOLUME CLAIMS (PVC)

# This is a solution for cluster-wide storage
# PV is a k8s object that defines available storage
# Pods cant use PV directly
# PVC is a storage abstraction pods use, it just requests storage from application
# PVC gets matched to PV by k8s
# Once PVC claimed PV nothing else can claim same PV
# If PVC is created and cant find PV it continues to exist but is not usable
# If PVC ommits storageClass it will create a PV of default class (defined by env like EKS AKS) and attach itself to it
# Storage classes can be custom created and have provisioner, reclaimPolicy, volumeBindingMode

# DEPLOYMENTS

# Deployment manages a ReplicaSet controller which in turn manages pods
# You can manually create a ReplicaSet controller
# Deployment manages deployment mechanisms through multiple ReplicaSets