# help in a packaging tool for k8s
# helm adds":
# a concept of application, bundling related yaml files together
# a templating language that allows the variables to be dynamic in yaml files
# a better rollback mechanism
# its own set of commands

# chart is an application package
# chart can be developed and deployed locally and published to a repo (similar to Docker Hub)
# release is an installed chart
# every release has a name
# multiple instances of the same chart can be installed with separate release names

# chart contains k8s manifests with parametrized values
# chart.yaml - config for chart metadata
# values.yaml - default values for parametrized settings in k8s manifests
# templates - folder with app manifests
