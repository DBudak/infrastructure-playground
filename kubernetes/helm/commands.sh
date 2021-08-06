# create a default helm
helm create <chart name>

# inspect default values in chart
helm show values <chart name> --version <chart version>

# install the chart
helm install <chart name> --version <chart version>

# install with default dependencies and values
helm install <chart name> --version <chart version> --dry-run

# install the chart overwriting default values
helm install --set <name>=<value> <chart name> --version <chart version>

# check installed releases
helm ls

# remove release
helm uninstall <release name>

# add official helm repo
helm repo add stable https://charts.helm.sh/stable --force-update

# install chart from remote
helm install repo stable/chartmuseum --version <version> --wait

# package a chart
helm package <path>

# git fetch equivalent
helm repo update

# verify that chart exists
helm search repo <name>

# get subchart dependencies ready
helm dependency build <chart path>
