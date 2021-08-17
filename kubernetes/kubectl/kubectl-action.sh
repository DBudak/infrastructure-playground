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

# change spec of selected object on a fly
kubectl set image deployment/<deployment name> <image path>/<image name>

# APP MANIFESTS

#deploy from manifest file
kubectl apply -f <file>.yml

#create configmap from env file
kubectl create configmap <config name> --from-env-file=<file path>

# COPY FILES
kubectl cp <pod name>:<pod path> <local path>

# DELETING

#delete all <entity>
kubectl delete <entity> --all

# ROLLOUS ROLLBACKS

# initiate a rollout
kubectl apply...

# initiate a rollback
#   --dry-run allows to see what will happen without applying it
#   --to-revision=2 will rollback to specific revision
kubectl rollout undo <deploy> --dry-run --to-revision=2

# deploy to a specific namespace
kubectl apply -f <file> --namespace <namespace>

# gets contexts
kubectl config get-contexts

# update default namespace for current cuntext
kubectl config set-context --current --namespace=<namespace>