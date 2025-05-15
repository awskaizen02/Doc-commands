K8s cluster are made u of nodes
There are two types of nodes
     Master node: This is responsible for managing the cluster
     Worker Node(minions):  these execute workloads(your applications)


Control Plane: Master Node
	- API SERVER
	- SCHEDULAR
	- CONTROLLER MANAGER
	- ETCD

Worker Node:

	- kubelet
	- kubeproxy
	- Docker
	- POD
	- Container

To deploy our applications in K8s cluster , we have to communicate with Control Plane.

Note:- To communicate with control plane we use "kubectl" software

Master Node Components:

Api server:
----------
	This component is responsible for all communications external as well insternal in K8S cluster.
	For client it looks a if API server iteself
	Expose rest API for k8s clients(kubectl, libraries) to interact

[API Server will recive request from kubectl and it will store request in ETCD with pending status]

ETCD:
----
	This is memory for k8s cluster
	This is a distribute key value store

[ETCD is an internal database used by K8S cluster.]

Scheduler:
---------
	Scheduler is responsible for scheduling new workloads (pods) on a suitable node

[ Schedular will identify pending requests available in ETCD and it will schedule that task for execution in worker node]

Note: - Schedular will use kubelet to identify worker node for task assignment

Controller Manager:
-------------------
	This is responsible for maintaining the desired state
[ Controller Manager is responsible to check all the tasks are executing as expected or not in K8S cluster.	]

Cloud Controller Manager:
------------------------
	optional , used for managed K8S: this component is part of managed k8s (AKS,EKS,GKE) which can help to estalish connecton with cloud natively




NODE:
----
kubelet:
--------
	This is an agent of control plane(Master Node)
	This recieves instructions from control plane and execute them.

[kubelet will act as worker node agent]

Kube-Proxy:
----------	
	This is responsible for networking services

[kube proxy will provide N/W required for cluster communication]

Container Runtime:
-----------------
	To create containers we need container runtime
	k8s allows us to use any container runtime which is CRI(container runtime interface) compliant	

[
Docker engine is used to run docker containers in worker nodes
in K8s everthing will be respensented as a POD only

Note:- docker container will be created inside the POD
 - POD represents running insance of our application


K8s setup
---------
	self managed cluster (we are responsible to setup everthing)
		minikube (single node) (only for pratice)
		kubeadm  (multi node cluster)

	Prvider Managed Cluster (Ready made cluster fo rent)
		AWS 	EKS
		AZURE 	AKS
		GCP	GKE


# minikube # https://minikube.sigs.k8s.io/docs/start/?arch=%2Fwindows%2Fx86-64%2Fstable%2Fchocolatey

what is POD?
- POD is a smallest building block in the k8s cluster
- Applications will be deployed as POD in k8s

NOTE: to create pods we will use docker images.

- to create pods we will use manifest YML file
- from single docker image we can create multiple PODS
- If we run appication with multiple pods then we will get High availability and LoadBalancing
- PODS count can be increased and decreased based on the demand (scalability)

-----YML or YAML (Yet another markup language)
- It is used to store the data in human and machine readable format
- YML/YAML files will have extensions as .yml or .yaml

Note:- indentation is very important in YML files

------1.yml
---
id: 23
name: kaizen
gender: Male
hobbies:
  - music
  - chess
  - story telling
  - watching movies

------2.yml

---
persion:
  id: 23
  name: kazen
  gender: Male
  address:
    area: vadapalani
    city: chennai
    state: TN
  skills:
    - AWS
    - Devops
    - AZURE
    - DE
    - DS
    - Linux


K8S manifest yaml
---------------------
apiVersion: <version-number>
kind: <resource-type>
metadata: <name>
spec: <container>



  	


