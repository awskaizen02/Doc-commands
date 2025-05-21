apiVersion: v1
kind: ConfigMap
metadata:
  name: game-demo
data:
  # property-like keys; each key maps to a simple value
  player_initial_lives: "3"
  ui_properties_file_name: "user-interface.properties"

  # file-like keys
  game.properties: |
    enemy.types=aliens,monsters
    player.maximum-lives=5    
  user-interface.properties: |
    color.good=purple
    color.bad=yellow
    allow.textmode=true  



# Using docker run:
$ docker run -d -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=yourStrong(!)Password" --name my-mssql-server -p 1433:1433 rapidfort/microsoft-sql-server-2019-ib:latest

 ## https://kubernetes.io/docs/concepts/configuration/configmap/

for every envirnment, application properties will be different
	DB properties
	Redis properties
	SMTP properties

## we don't need to hardcore application properties

Config Map and Secret concept are used to avoid hard core propertties in the application

Config Map is used to store data in key-value (non-confidential)

Config Map allows us to de-copule application properties from docker imags.
so that our application can be deployd into any environment without making any changes for our docker images.


Secret is also one of the k8s resource
Secret is used to store confidential data in key-value format
Secret is used to store confidential data in encoded format.
# https://www.base64encode.org/

## There are four different ways that you can use a ConfigMap to configure a container inside a Pod:

Inside a container command and args
Environment variables for a container
Add a file in read-only volume, for the application to read
Write code to run inside the Pod that uses the Kubernetes API to read a ConfigMap

# config-map.yaml manifest

---
apiVersion: v1
kind: ConfigMap
metadata:
  name: web-db-configmap
  labels:
    str: web-db-str
data:
  DB_DRIVER_NAME_VALUE: com.mysql.cj.jdbc.driver
  DB_SERVICE_NAME_VALUE: web_db_service
  DB_SCHEMA_VALUE: webapp
  DB_PORT_VALUE: 3306


## https://kubernetes.io/docs/concepts/configuration/secret/

# secret.yaml

---
apiVersion: v1
kind: Secret
metadata:
  name: web_db_secret
  labels:
    secret: web_db_secret
data:
  DB_USER_NAME_VALUE: YWRtaW4=
  DB_PASSWORD_VALUE: YWRtaW4=
type: Opaque
  
		
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-db-deployment
  labels:
    app: web-db
spec:
  replicas: 3
  selector:
    matchLabels:
      app: web-db-pod
  template:
    metadata:
       labels:
         app: web-db-pod
    spec:
     containers:
     - name: web-app-db
       image: mysql
       ports:
       - containerPort: 3306
       env:
       - name:  MYSQL_ROOT_PASSWORD
         valueFrom:
           secretKeyRef:
             name: web-db-secret
             key: DB_PASSWORD_VALUE
       - name: MYSQL_DATABASE
         valueFrom:
           configMapKeyRef:
             name: web-config-map
             key: web-bd

---
apiVersion: v1
kind: Service
metadata:
  name: web-db-service
  labels:
   app: web-db-service
spec:
  type: ClusterIP
  ports:
  - port: 3306
    targetPort: 3306
  selector:
    app: web-db-pod

