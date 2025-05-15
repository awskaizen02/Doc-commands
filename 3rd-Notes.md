Services:
	clusert-ip: works inside the n/w	
	nodeport
	LB
	external-DNS

clusert-ip
* when pod creates, every pod will get unique ip address
* we can access pod inside cluster using its ip address
* PODS are short lived objects, when POS is recreated its ip will be changed , so we cannot depend on POD-IP to access

* to expose POD access with in the cluster we can use Cluster-IP service
* Cluster-Ip will generatye one IP to access pods with in cluster
* Cluster-IP will not changed when PODS are re-created

NODE-Port:
* Nodeport service is used to expose pods outside cluster also
* when we use NodePort service we can specify Node Port number in servic manifest file
* If  we dont specify NodePort Number then K8s will assign random Node Port Number

Node-port range = 30000 - 32767

```
---
apiVersion: v1
kind: Pod
metadata:
  name: webapppod
  labels:
    app: webapp
spec:
  containers:
  - name: webappcontainer
    image: dockerpandian/tomcat:1
    ports:
     - containerPort: 8080
```
```
---
apiVersion: v1
kind: Service
metadata:
  name: webappsvc
spec:
  type: NodePort
  selector:
    app: webapp
  ports:
   - port: 80
     targetPort: 8080
```
LoadBalancer:
* single contact point , using LB URL we can our application
* it  is used to expose our PODS outside cluster using LB
* when we use LB as service type, then LB will create and managed by AWS
* LB will distribute the traffice to multiple worker in Round Robin method.
```
---
apiVersion: v1
kind: Pod
metadata:
  name: webapppod
  labels:
    app: webapp
spec:
  containers:
  - name: webappcontainer
    image: dockerpandian/tomcat:1
    ports:
     - containerPort: 8080

---
apiVersion: v1
kind: Service
metadata:
  name: webappsvc
spec:
  type: LoadBalancer
  selector:
    app: webapp
  ports:
   - port: 80
     targetPort: 8080

```

# https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/

Namespaces
In Kubernetes, namespaces provide a mechanism for isolating groups of resources within a single cluster. Names of resources need to be unique within a namespace, but not across namespaces. Namespace-based scoping is applicable only for namespaced objects (e.g. Deployments, Services, etc.) and not for cluster-wide objects (e.g. StorageClass, Nodes, PersistentVolumes, etc.


When to Use Multiple Namespaces
Namespaces are intended for use in environments with many users spread across multiple teams, or projects. For clusters with a few to tens of users, you should not need to create or think about namespaces at all. Start using namespaces when you need the features they provide.

Namespaces provide a scope for names. Names of resources need to be unique within a namespace, but not across namespaces. Namespaces cannot be nested inside one another and each Kubernetes resource can only be in one namespace.

```
---
apiVersion: v1
kind: Namespace
metadata:
  name: hippons

---
apiVersion: v1
kind: Pod
metadata:
  name: webapppod
  labels:
    app: webapp
  namespace: hippons
spec:
  containers:
  - name: webappcontainer
    image: dockerpandian/tomcat:1
    ports:
     - containerPort: 8080

---
apiVersion: v1
kind: Service
metadata:
  name: webappsvc
  namespace: hippons
spec:
  type: NodePort
  selector:
    app: webapp
  ports:
   - port: 80
     targetPort: 8080
```

Namespaces are a way to divide cluster resources between multiple users (via resource quota).

It is not necessary to use multiple namespaces to separate slightly different resources, such as different versions of the same software: use labels to distinguish resources within the same namespace.

Note:
For a production cluster, consider not using the default namespace. Instead, make other namespaces and use those.

in k8s will have below namespace 
	* default
 	* Kube-public
	* kube-system
	* kube-node-lease

default: where resources fo if no namespace is specified

kube-system: system components

kube-public: readable by all users

kube-node-lease: node heartbeat tracking


pod
service cluster-ip,nodeport,lb
namespace

# https://kubernetes.io/docs/concepts/workloads/controllers/replicationcontroller/

## Replication Controller(RC)
------------------------------

* It is kubernetes component which is used to create PODS
* It will make sure always given no. of pods are running for our application
* like autoscaling , it will take care of POD lifecycle 
* When POD is crashed /damaged/ deleted RC will take of new PODS as we mentation  the limites
* we can scale-up and scale-down PODS count using RC


## https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/

#ReplicaSet
* ReplicaSet is replacement for ReplicationController ( it is nextgen component in k8s)
* ReplicaSet is also used to manage POD Lifecycle
* ReplicaSet also  will maintain given no of pods 
* using replicaSet can maintain the count of PODS ( scaleup and scale-down)

```
---
apiVersion: v1
kind: ReplicationController
metadata:
  name: webapprc
spec:
  replicas: 3
  selector:
    app: webapp
  template:
    metadata:
      name: webapppod
      labels:
        app: webapp
    spec:
      containers:
      - name: webappcontainer
        image: dockerpandian/tomcat:1
        ports:
         - containerPort: 8080

---
apiVersion: v1
kind: Service
metadata:
  name: webappsvc
spec:
  type: NodePort
  selector:
    app: webapp
  ports:
   - port: 80
     targetPort: 8080
```

### The only difference b/w Replication Controller and ReplicaSet is 'selector'

## Replication Controller supports Equality based selecor

selector:
  app: webapp


## ReplicaSet supports Set based selecor 

selector:
   matchLabels:
      app: webapp
      version: v1
      type: backend

```
---
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: frontend
spec:
  replicas: 3
  selector:
    matchLabels:
      app: frontend
  template:
    metadata:
      labels:
        app: frontend
    spec:
      containers:
      - name: webappcontainer
        image: dockerpandian/tomcat:1

---
apiVersion: v1
kind: Service
metadata:
  name: webappsrc
spec:
  type: NodePort
  selector:
    app: webapp
  ports:
   - port : 80
     targetPort: 8080

```



# https://kubernetes.io/pt-br/docs/reference/kubectl/cheatsheet/


# Comandos get com saída simples
* kubectl get services                          # Lista todos os serviços do namespace
* kubectl get pods --all-namespaces             # Lista todos os Pods em todos namespaces
* kubectl get pods -o wide                      # Lista todos os Pods no namespace atual, com mais detalhes
* kubectl get deployment my-dep                 # Lista um deployment específico
* kubectl get pods                              # Lista todos os Pods no namespace
* kubectl get pod my-pod -o yaml                # Obtém o YAML de um pod


# Comandos describe com saída detalhada
* kubectl describe nodes my-node
* kubectl describe pods my-pod

# Lista serviços classificados por nome
* kubectl get services --sort-by=.metadata.name
