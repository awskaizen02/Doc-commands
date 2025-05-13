#  eksctl create cluster --name kaizen --region ap-south-1  --node-type t2.medium --zones ap-south-1a,ap-south-1b

# https://kubernetes.io/docs/concepts/workloads/controllers/deployment/

Replication Conrtoller
```
---
apiVersion: v1
kind: ReplicationController
metadata:
  name: nginx
spec:
  replicas: 3
  selector:
    app: nginx
  template:
    metadata:
      name: nginx
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx
        ports:
        - containerPort: 80

```

it is used to create PODS
it will make sure always maintain given no.of pod running  as we mentaine in manifest


we can scale up and scale down the pods count using replication controller
------------------------------------------------------------
Replicaset
```
---
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: frontend
  labels:
    app: webapp
    version: v1
    tier: frontend
spec:
  # modify replicas according to your case
  replicas: 3
  selector:
    matchLabels:
      tier: frontend
  template:
    metadata:
      labels:
        tier: frontend
    spec:
      containers:
      - name: php-redis
        image: us-docker.pkg.dev/google-samples/containers/gke/gb-frontend:v5

```
both replicaset and replica controller bother work are same only different 'selector'

## Replication Controller
```
  selector:
    app: nginx
 
```

## ReplicaSet
```
  selector:
    matchLabels:
      app: webapp
      version: v1		
      tier: frontend
```

Deployment
----------
	- "Deployment is one of the kubernetes component" 
	- "Deployment is the most recommended approach to deploy application in k8s cluster" 
	- "Using Deploymnet we can scale up/down our pods"  
	- "Deployment support Roll out and Roll back"  
	- "We can deploy latest code with Zero Downtime using Deployment" 

- "Zero Downtime Deployment"  
- "Rollout and Rollback"  
- "AutoScaling"  

- In Deployment we have 2 stratagies  
	* Recreate	 # delete all pods and create every pods in new	
	* Rolling update # delete pods one by one cand create new pods




## Failed Deployment  
 \n
  \n
Your Deployment may get stuck trying to deploy its newest ReplicaSet without ever completing. This can occur due to some of the following factors:
 \n
  \n
```
Insufficient quota
Readiness probe failures
Image pull errors
Insufficient permissions
Limit ranges
Application runtime misconfiguration
```

---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: webappdeployment
spec:
  replicas: 2
  strategy:
    type: Recreate
  selector:
    matchLabels:
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
      nodePort: 30555 


  
## https://kubernetes.io/docs/tutorials/kubernetes-basics/update/update-intro/	

### Blue - Green Deployment

It is one of the approach to deploy application

Blue green deployment is an application release model
It reduces risk and minimizes downtime
it uses 2 production environments, BLUE and GREEN
old version defin as blue environment
new version defin as green environment

* Rapid releasing
* Simple rollbacks
* Built-in Disaster Recovery
* Zero Downtime

##blue env

```
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: webappbluedeployment
spec:
  replicas: 2
  stateregy:
    type: RollingUpdate
  selector:
    matchLabels:
       app: webapp
       version: v1
       colour: blue
  template:
    metadata:
      name: webapppod
      labels:
        app: webapp
        version: v1
        colour: blue
    spec:
      containers:
      - name: webappcontainer
        image: dockerpandian/tomcat:1
        imagePullPolicy: always
        ports:
        - containers: 8080 
    
---
apiVersion: v1
kind: service
metadata:
  name: webapp1service
spec:
  type: NodePort
  selector:
    version:v1
  ports:
  - ports: 80
    targetPort: 8080
    nodePort: 30555



```

green
```
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: webappgreendeployment
spec:
  replicas: 2
  stateregy:
    type: RollingUpdate
  selector:
    matchLabels:
       app: webapp
       version: v2
       colour: green
  template:
    metadata:
      name: webapppod
      labels:
        app: webapp
        version: v2
        colour: green
    spec:
      containers:
      - name: webappcontainer
        image: dockerpandian/tomcat:1
        imagePullPolicy: always
        ports:
        - containers: 8080 
    
---
apiVersion: v1
kind: service
metadata:
  name: webapp2service
spec:
  type: NodePort
  selector:
    version:v2
  ports:
  - ports: 80
    targetPort: 8080
    nodePort: 30556
```

