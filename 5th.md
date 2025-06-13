 eksctl create cluster --name kaizen --region eu-north-1 --node-type t3.medium --zones eu-north-1a,eu-north-1b


DaemonSet:
A DaemonSet defines Pods that provide node-local facilities. These might be fundamental to the operation of your cluster, such as a networking helper tool, or be part of an add-on.
A DaemonSet ensures that all (or some) Nodes run a copy of a Pod. As nodes are added to the cluster, Pods are added to them. As nodes are removed from the cluster, those Pods are garbage collected. Deleting a DaemonSet will clean up the Pods it created.

Some typical uses of a DaemonSet are:

running a cluster storage daemon on every node
running a logs collection daemon on every node
running a node monitoring daemon on every node




in our ubuntu server need to install maven,tomcat
apt install maven -y

apt is the packet manager for ubuntu
yum / dnf is the packet manager for redhat

helm  is the packet manager for k8s
helm allows you to install or deploy applications on k8s cluster in a similar manner to yum/apt for linux distributions
helm will maintain chrts in chart repository
heml is used to install required softwares in k8s cluster

chart means colleation of configuration files organized in a directory
a running instance of a chart with a specific config is called a release


Before Helm in Kubernetes, deploying applications required manually creating and managing individual Kubernetes YAML files for each component. This process was complex, error-prone, and lacked version control. Helm addresses these issues by providing a package manager for Kubernetes applications, making deployment easier and more manageable



after helm : make it easy below items

	Simplified Deployment:
	Version Control:
	Simplified Configuration:
	Enhanced Reusability:
	Simplified Updates

# https://helm.sh/docs/intro/install/

$ curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
$ chmod 700 get_helm.sh
$ ./get_helm.sh




## https://artifacthub.io/packages/helm/metrics-server/metrics-server

helm repo add metrics-server https://kubernetes-sigs.github.io/metrics-server/

helm upgrade --install metrics-server metrics-server/metrics-server


we can monitor ous k8s cluster and cluster components using Prometheus, Grafana software

Prometheus:
	Prometheus is an open-source systems montoring and alerting toolkit
	Prometheus collects and stores its metrics as time series data
	it provides out-of-box monitoring capabilities for the k8s container platform

Grafana:
	Grafana is a analysis and monitoring tool
	Grafana is a multi-platform open source analytics and interactive visualization web application
	it provides charts, graphs and alerts for the web when connected to supported dta sources
	Grafana allows you to query, visulize, alert on and understand your metrics no matter where they are stored, create , explore and share dasboards.
 Grafana will connect with Prometheus for data source


using helm charts we can easily deploy Prometheus and Grafana

## https://artifacthub.io/packages/helm/prometheus-community/kube-prometheus-stack

helm repo add stable https://charts.helm.sh/stable

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

## https://artifacthub.io/packages/helm/prometheus-community/prometheus
helm install stable prometheus-community/kube-prometheus-stack

Edit Prometheus Service & change service type to LoadBalancer then save and close that file
$ kubectl edit svc stable-kube-prometheus-sta-prometheus

Now edit the grafana service & change service type to LoadBalancer then save and close that file
$ kubectl edit svc stable-grafana


Verify the service if changed to LoadBalancer
$ kubectl get svc


Use below credentials to login into grafana server

UserName: admin
Password: prom-operator
