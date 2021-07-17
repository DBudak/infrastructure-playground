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