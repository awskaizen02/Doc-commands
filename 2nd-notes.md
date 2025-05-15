eksctl create cluster --name kaizen --region ap-south-1  --node-type t2.medium --zones ap-south-1a,ap-south-1b

# https://kubernetes.io/docs/reference/glossary/?fundamental=true

WHAT IS POD
-----------

* POD is a smllest building block in k8s cluster
* in k8s, every container will be created inside POD only
* POS always runs inside node [ worker-nodes]
* POD represents running process
* POD means group of containers running on a node
* can create multiple PODS on single node
* Every POD will have unique IP address


* we can create PODs in 2 ways
	* Interactive Approach
* kubectl run --name<pod-name> image=<image-name> --generate=pod/v1
	* Declarative Approach(use Manifest YAML)	



# In the manifest (YAML or JSON file) for the Kubernetes object you want to create, you'll need to set values for the following fields:

### apiVersion - Which version of the Kubernetes API you're using to create this object
### kind - What kind of object you want to create
### metadata - Data that helps uniquely identify the object, including a name string, UID, and optional namespace
### spec - What state you desire for the object


yaml
----------
```
---
apiVersion:
kind:
metadata:
spec:

```

## https://kubernetes.io/docs/concepts/workloads/pods/

pod.yaml

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

# to create pods
```
kubectl apply -f <pod.yaml>
```
#display all pods
```
kubectl get pods
kubectl get po
```
# display detail about the pod 
```
kubectl get po -o wide
```
# Describe pod (more information about the pos)
kubectl describe pod <pod-name>

# to get the logs of pod
kubectl logs <pod-name>

--------------------------------------------
## PODS we canot access ouside
### we need to expose PODS for outside access using kubernetes Service concept.

Kubernetes services is used to expose PODS outside cluster

# https://kubernetes.io/docs/concepts/services-networking/service/

# Kubernetes Service types allow you to specify what kind of Service you want.

## The available type values and their behaviors are:

### ClusterIP
	Exposes the Service on a cluster-internal IP. Choosing this value makes the Service only reachable from within the cluster. This is the default that is used if you don't explicitly specify a type for a Service. You can expose the Service to the public internet using an Ingress or a Gateway.

###NodePort
	Exposes the Service on each Node's IP at a static port (the NodePort). To make the node port available, Kubernetes sets up a cluster IP address, the same as if you had requested a Service of type: ClusterIP.

###LoadBalancer
	Exposes the Service externally using an external load balancer. Kubernetes does not directly offer a load balancing component; you must provide one, or you can integrate your Kubernetes cluster with a cloud provider.

###ExternalName
	Maps the Service to the contents of the externalName field (for example, to the hostname api.foo.bar.example). The mapping configures your cluster's DNS server to return a CNAME record with that external hostname value. No proxying of any kind is set up.

### Nodeport
-------------

service.yaml

```
apiVersion: v1
kind: Service
metadata:
  name: webappsvc
spec:
  type: NodePort
  selector:
    app.kubernetes.io/name: webapp
  ports:
    - port: 80
      targetPort: 8080
      nodePort: 30030
```
kubectl appy -f <service.yaml>

kubectl get svc

kubectl delete all --all

### Cluster IP
* when we create PODS, every pod will get unique IP address
* We can access POD inside cluster using its IP address

** PODS are short lived objects, when pod is recreated its ip will be changed so we cannot depend on POD IP to acess.

* To expose POD access with in the cluster we can use clusterIP serice

* ClusterIp will generate one IP address to acess our PODS with in cluster

** ClusterIP wil not change when pods are re-created

----------
service.yaml

```
apiVersion: v1
kind: Service
metadata:
  name: webappsvc
spec:
  type: ClusterIP
  selector:
    app.kubernetes.io/name: webapp
  ports:
    - port: 80
      targetPort: 8080

```

NODE PORT RANGE = 30000 - 32767

## pod and service join manifest
-------------------------------------

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
  type: NodePort
  selector:
    app.kubernetes.io/name: webapp
  ports:
    - port: 80
      targetPort: 8080
      nodePort: 30030
```

eksctl delete cluster --name kaizen --region ap-south-1  
