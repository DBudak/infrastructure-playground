# GENERAL

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
# Pods can have multiple containers
# Additional containers mount via volumes
# Default multi container pod pattern is sidecar
# In sidecar all containers need to be ready for Pod to be ready
# Init is another pattern, init containers run sequentially
# Ambassador pattern is good for networking containers
# Only helper containers should be added to a single container pods since every container adds a point of failure that is not managed by k8s directly
# Each container has a compute layer isolation
# Adding shareProcess-Namespace: true removes the above and allows containers to access processes of each other on the same pod
# Can have multiple labels like appname label and version label

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

# STATEFUL SET

# Unlike ReplicaSet (created under the hood by Deployments) Stateful Set:
# Creates Pods with predictable names
# Pods can be individually acessed over DNS
# Pods are started in order
# Useful for databases
# Can have volumeClaimTemplate that acts as a pre-defined PVC
# Managed DB environments should be considered for dbs instead of StatefulSets because the latter are complex

# JOBS and CRONJOBS

# Job is a Pod controller
# Job runs a Pod and a container inside it
# Jobs need to be finished to completion
# Job has standard Pod spec with required restartPolicy field
# Job add job name to the pod name that they create
# Job spec supports completions param defining how many time Job should run
# Job spec has parallelism param that controls how many Pods to run in parallel to reach completions
# CronJob is a Job with Linux Cron timer setup that runs every X days/miuntes/seconds etc
# CronJobs don't use label-based selector ownership because they don't own Jobs

# ROLLOUTS ROLLBACKS DEPLOYMENT STRATEGIES

# Every time a change is applied to Deployment Pod spec a rollout is initiated
# In rollout Deployment creates new ReplicaSet and scales it to desired number of Pods
# Rollouts are only trigerred from changing Pod Spec. Changing Deployment or ReplicaSet does not initiate or require a rollout
# Rollback is initiated via rollout undo command
# If --dry-run is added to above it will only show what would happen not apply it
# Rolling update is the dafault strategy for rollouts
# Another strategy is Recreate which brings everything down and then scales everything up. Should be avoided.
# maxUnavailable setting allows to control how many Pods can be unavailable during update
# maxSurge allows to control how many extra Pods can exist
# minReadySeconds adds the delay Deployment will wait to make sure new Pods are stable
# progressDeadlineSeconds specifies the amount Deployment can run before it is considered a failure. Default is 600 seconds

# NAMESPACES

# Namespaces are a grouping mechanism
# Every k8s object belongs to a Namespace
# Can use multiple Namespacses to divide cluster into virtual clusters
# Namespaces can be defined with yaml
# Context sets the default Namespace to use in kubectl commands 

# SELF HEALING

# Readiness Probe takes action at network level, pinging container
# If above check result is unhealthy it removes the Pod from the Service managed list
# Liveliness Probe  takes action at compute level
# If above check result is unhealthy it restarts the container inside the Pod
# Deploytments can have a spec defining max allowed memory quota
# ResourceQuota can be created to manage CPU and RAM on namespace level
# CPU limits in Deployment specs are measured in micro-cores (1000 m = 1 core)

# LOGS AND MONITORS

# Fluentd and Elastic Search for logging
# Prometheus for monitoring
# Prometheus is only and aggregator, app itself needs to provide monitors 

# SECURITY

# K8s has many security features ALL OF WHICH ARE OFF by default
# Securing apps in k8s is about limiting network access, what containers can do and access to k8s API
# Ingress objects control access to HTTP routes, but that applies only to external access
# Network Policy is a k8s object to control internal network access within the cluster
# Network Policies work like firewalls: block traffic to or from specific ports on Pods
# Network Policy supports blanket deny-all rules
# Network Policy DOES NOT provide any security on its own and needs network implementation on the cluster to enforce the rules it provides
# To apply Network Policy rules create a custom cluster using Kind with Calico
# For Network Policy recipes see https://github.com/ahmetb/kubernetes-network-policy-recipes
# By default all Linux based containers are created with root user
# By default Kubernetes token is accessible in any container to use K8s API
# With the two above any attacker who gets inside the container has access to all other containers AND k8s API
# Pods can specify the user for container via SecurityContext field in its spec
# NOTE that port 80 is not accessible to non root users in Linux, so move the app to a different port
# If Pod does not need to access k8s API (most don't) add automountServiceAccountToken: false to its spec
# To fine grain control user capabilities add capabilities field into Pod spec
# ValidatingAdmissionWebhook implements custom logic to allow/block resource creation
# MutatingAdmissionWebhook edits the created object implicitly using custom logic
# Logic for wehooks can be written in any language
# Webhooks easily get messy and produce unexpected results
# OPA (Open Policy Agent) is a unified approach of writing policies
# OPA Gatekeeper: 1. deploy it in a cluser 2. create comstraint template
# OPA uses Rego (raygo) language
# Best practices for policies:
# All Pods must have container probes defined 
# Pods can run containers only from approved image repositories
# All containers must have memory and CPU limits
# Steps to secure k8s environment (not exhaustive list):
# Adopt security contexts, then network policies, then admission control

# SECURITY: PERMISSIONS

# Kubernetes supports least-privilege acess with role-based access control (RBAC)
# RBAC applies to end users and to services. But they require different controllers
# RBAC works by granting permissions to perform actions on resources
# Permissions are applied to a subject, which can be user, system account or group
# Permissions are applied indirectly through roles
# RBAC defines Role and RoleBinding objects to work on namespaced object
# RBAC defines ClusterRole and ClusterRoleBinding objects to work on whole cluster
# K8s does not authenticate end users so clusters rely on external identity providers to authenticate
# Active Directory, LDAP, OpenID Connect (OIDC) are the mostp opular identity management systems
# Permissions are all additive so subjects start with NO permissions and end up with sum total of their roles
# Any namespace has a default service account and any Pods that don't specify a service account will use a default
# Service accounts manage access to API. Best practice is to create a separate service account for each service
# Note that Service accounts are only needed for things like Prometheus, business apps dont need K8s API
# If no service account is specified each app ADDS its permissions to default account. Which ends up with default account ability to do way too much
# In RBAC resources NEED TO EXIST before roles can be applied
# K8s runs manifests in file order so if using above name files like 01- 02- 03- etc with roles AFTER the resources
# K8s has can-i command to check if a user can perform an action
# Additional commands are plugins: who-can (inverse of can-i), access-matrix, rbac-lookup
# Best practices: 
# Start with predefined cluster roles and limit admin role usage
# Use namespaces as security boundary to limit the scope further
# Use service accounts sparingly and only for services that need k8s API access

# DEPLOYMENTS

# Control plane is the management side of the cluster
# Nodes run workloads inside the cluster
# Control plane receives kubectl requests and actions them by scheduling Pods on Nodes
# In managed env control plane is taken care of. In EKS it is completely abstracted
# Cluster needs API server, Scheduler and Control manager to function
# API server is a REST API with HTTPS endoints that receive kubectl commands
# Scheduler watches for new Pod requests and selects a node to run them
# Controller manager runs core controllers
# Etcd is k8s data store where all cluster data is stored
# You need to run multiple control nodes for high availability since if it goes down you can't interact with k8s
# Kubelet is background agent running on a server that manages Pod lifecycle and seds health checks to API server for Node health
# Kube-proxy is a network component that routes traffic between Pods
# Container Runtime is used by Kubelet to manage Pod Containers, ie Docker
# Kubeadm is a tool that takes care of deploying k8s

# SCALING AND WORKLOAD PLACEMENT

# When new Pod is created it goes into Pending state until its allocated to a Node
# Scheduler's job is to find a suitable Node for pending Pods
# Scheduling has two parts filtering and scoring
# Filtering excludes unsuitable Nodes
# Scoring ranks remaining Nodes to find the best option
# Nodes can have Taints to mark them as not suitable for general work
# Master Taint is applied to Control Plane Nodes to make sure no workload runs on them
# Pods can tolerate certain Taints. Tolerations are specified in Deployment specs
# Taints and Tolerations should be only used to express negative scenarios
# Positive scenarios should use Affinity and Antiaffinity
# Affinity can be claimed in Deployment spec to ensure Pods land on certain Nodes
# Pods can express Affinity to other Pods so they are scheduled to land on same Node
# Reverse logic above for Antiaffinity
# K8s auto scales application by adding or removing Pods (horizontal)
# K8s wont auto scale until it has a metrics-server to use for in-time health checks
# Version 2 of scaling spec allows to use any metrics for scaling, like HTTP request quantity, Prometheus metrics etc
# K8s can sometimes evict a Pod if it thinks a Node is working to hard 
# K8s will attempt to restart evicted Pod on a different Node
# Evicted Pods stay on the Node with stopped containers for later troubleshooting
# Pod eviction is rare and happens in extreme circumstances where Node would fail anyway
# Deployment Spec can specify Priority Class for Pods to make sure they are evicted last. The larger the value the more important it is
