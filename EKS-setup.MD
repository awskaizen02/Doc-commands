* create EC2 instacne t2.micro
* create IAM role with Administrator access
* attach iam role into ec2-instance

login to the ec2 instace and install aws cli

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install



# kubectl ## https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html

# choose the version n-1

** curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.31.3/2024-12-12/bin/linux/amd64/kubectl

** chmod +x ./kubectl

** mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH

** kubectl version --client


# EKSCTL ## https://eksctl.io/installation/

# for ARM systems, set ARCH to: `arm64`, `armv6` or `armv7`
** ARCH=amd64
** PLATFORM=$(uname -s)_$ARCH

** curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"


** tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz

** sudo mv /tmp/eksctl /usr/local/bin

**  eksctl version
```
eksctl create cluster --name <cluster_name> \
--region <region_name> \
--node-type <instance_type> \
--node-min <count> \
--nnode-max <max> \
--zones <az-1a>,<az-1b>
```

```
eksctl create cluster --name kaizen --region ap-south-1  --node-type t2.medium --zones ap-south-1a,ap-south-1b
```

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
````
eksctl delete cluster --name kaizen --region ap-south-1 


# https://kubernetes.io/docs/reference/generated/kubernetes-api

Kind: resources [pod,services,namespaces,nodes,secrets,configmap..]
```
pod(v1)		: the smallest deployment units in k8s, running one or morecontainers	
deployments(apps/v1) : mange statless applications, ensuring replica counts
stsefulsets(apps/v1) : manage stategul applications with stable n/w identities
DaemoSets(app/v1)    : ensure pod running one every nodes
job/cronjobs(btach/v1): scheduled tasks 
```


# https://kubernetes.io/docs/concepts/services-networking/service/
```
---
apiVerrsion: v1
kind: Service
metadata:
  name: webappsrc
spec:
  type: NodePort
  selector:
    app: webapp
  ports:
  - port:80
    targetPort:8080
    nodePort: 30070
```

```
---
apiVersion: v1
kind: Namespace
metadata:
  name: kaizen-ns
```
```
---
apiVersion: v1
kind: Pod
metadata:
  name: webapppod
  namespace: kaizen-ns
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
apiVerrsion: v1
kind: Service
metadata:
  name: webappsrc
  namespace: kaizen-ns
spec:
  type: NodePort
  selector:
    app: webapp
  ports:
  - port:80
    targetPort:8080
    nodePort: 30070
```

