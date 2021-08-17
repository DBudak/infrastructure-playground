# reads as kube cuttle as in cuttlefish
# a cli tool that connects to a cluster and works with k8s API

#GitVersion is the actual version
kubectl version

#show all entites
kubectl get all

#show the list of nodes powering the cluster
kubectl get nodes

#see the full list of pods in cluster
kubectl get pods

#get detailed info about pod
kubectl describe pod <podname>

#see logs for specific pod
kubectl logs <podname-id>

#check deployment history
kubectl rollout history deploy/<deploy name>