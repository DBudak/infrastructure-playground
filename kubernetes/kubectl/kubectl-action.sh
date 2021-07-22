# PODS

#run a single pod
# --image set an image to run from
# --restart set if restart pod  
kubectl run <name> --image=<image path> --restart=Never

#wait for the pod to be ready
kubectl wait --for=condition=Ready pod <podname>

#port forward from 8080 in local to  80 in cluster
kubectl port-forward pod/<pod name> 8080:80

#connect and run interactive shell in the Pod
kubectl exec -it <name> -- sh

#get logs from a pod
kubectl logs --tail=2 <podname>

# CONTROLLERS

#create a Deployment controller
kubectl create deployment <name> --image=<image path>

# APP MANIFESTS

#deploy from manifest file
kubectl apply -f <file>.yml

# COPY FILES
kubectl cp <pod name>:<pod path> <local path>

# DELETING

#delete all <entity>
kubectl delete <entity> --all