# devops-django-polls
Simples devops django polls infrastructure example.


# Introduction
That is a copy/paste from different projects. So, don't be surprised if you found crazies variables names or comments, because I spent more time in this README than the code !! :D

# Comments

### What I have done:
1. Sorry to don't make a PR for the original project, but I have seen the reply from the other candidates in your github repository and I don't think it is a good idea. :-(

2. I have create the DockerFile only because you have requested it, I believe a better alternative in this case is to use [https://nixos.org/](https://nixos.org/) to have a smallest (inclusive small than alpine) and secure docker image.

3. I have changed some code inside of **settings.py** to increase the portability (we can now change many options direct from the kubernetes configmaps and secrets), for example:
* SECRET_KEY
* DEBUG
* ALLOWED_HOSTS
* DATABASES
* STATIC_URL

4. I have changed from SQLite to PostgreSQL to have a real database (haha) and to allow multiple clients access to the same DB at time.

5. I have added an InitContainer to run at the beginner and make all the database migrations automatically on deploy.

6. We are using Kustomization to be more easy and standard to change from one enviroment to another for example.


### TODO/FIX:
1. Generate and upload static files direct to CDNs (maybe at the same InitContainer)
2. Make the database to be HA.
3. Configure TLS to http traffic.
4. Correct the "enviroments" folder name (only now I saw it).


# Prerequisites
- Kubernetes version 1.9 or higher.
- Kubernetes CLI kubectl v1.9 or greater.
- A cluster with at least 3 nodes having 2 vCPUs each.

# Installation

### Get the code

- Clone this repository:
```
git clone https://github.com/vhsantos/devops-django-polls
```


### Configuration

You will need to:
1. Change the **devops-django-polls/k8s/application/env_secrets** before deploying the infrastructure. In this file, you will need to set up **ALL** variables to be used by the DJANGO and DATABASE.

```
vim ./devops-django-polls/k8s/application/env_secrets
```

> Note: This file actually has all the variables pre-configured to this example, but you ***SHOULD NEVER*** put passwords in your repository.

2. You will need to create a **secret.yaml** file inside of the **devops-django-polls/k8s/application/** directory using the **env_secrets** file from the previous step.

```
kubectl --namespace=vhs create secret generic django-polls-secret --from-env-file=./devops-django-polls/k8s/application/env_secrets -o yaml --dry-run=client > ./devops-django-polls/k8s/application/secret.yaml
```


### Deployment

You only need to run this command to deploy all the infrastructure:
```
kubectl apply -k application/
```

This command will:
- Create a namespace "vhs".
- Deploy a PostgreSQL database (only one replica).
- Create a PostgreSQL database, database username and database password using the variables from **secrets.yaml**.
- Download the Django/Gunicorn docker image from [testdtestd/django-polls](https://hub.docker.com/repository/docker/testdtestd/django-polls) repository (see the Dockerfile).
- Deploy a InitContainer using the Django/Gunicorn image and make all the database migrations automatically to postgresql.
- Deploy 3 images from Django/Gunicorn and expose the port 8000/tcp.
- Create a Ingress configuration to redirect all traffic incomming to **django-polls.domain.com** address on port 80/TCP to Django/Gunicorn containers.


### Post-Installation

The systems deploy, configure and populate the database, but it is still necessary to create the admin user manually. So, run this command to connect to a Django/Gunicorn container and create the admin user:

```
kubectl exec -it deploy/django-polls -- python manage.py createsuperuser
```

> Note: Is possible to automatizate these tasks, but by security and importance of these tasks and because we will only run it once, I recommend to make it manually.


### Access
To access this system via browser, you will need one of this options:

##### Edit your hosts files
You will need to add the FQDN **django-polls.domain.com** and **polls.domain.com** associate with the IP of your cluster. In my case (minikube), I have this in my **/etc/hosts** file:

```192.168.49.2 django-polls.domain.com polls.domain.com```


##### Change the k8s configuration
You can edit the file **k8s/application/service.yaml** and change the line:
```- host: django-polls.domain.com```
to the new FDQN that you want to use to access your cluster.

***Remember that you will need to add this new FQDN to your DNS too.***


After this, you can open this address
[http://django-polls.domain.com/polls](http://django-polls.domain.com/polls)
[http://django-polls.domain.com/admin](http://django-polls.domain.com/admin)

in your browser to access the poll system and the django admin.




# Changes/Customization
You can use the kustomize's files in the directory **enviroments/[dev|prod]** to change or add new parameters to this containers. For example:
```
cat enviroments/prod/replica_count.yaml

apiVersion: apps/v1
kind: Deployment
metadata:
name: django-polls
spec:
replicas: 6
```

This file will add 3 new Django/Gunicorn replicas to the cluster. So, after you make the changes you can apply the new configurations using the command:

```
kubectl apply -k enviroments/prod/
```

> Note: After this command, your FQDN access will be **http://polls.domain.com**, because we have changed this in the **k8s/enviroments/prod/service.yaml** too.


# Cleanup
To reset or delete all this configuration, use this command:

```
kubectl delete namespace vhs
```


# Softwares
- **PostgreSQL database**
website: https://www.postgresql.org/
docker: https://hub.docker.com/_/postgres
docker image: postgres:12

- **Python - alpine docker base image.**
website: https://python.org/
docker: https://hub.docker.com/_/python
docker image: python:3.9.1-alpine3.12

- **From pip (requeriments.txt):**
Django: django==2.2.13
Gunicorn: gunicorn==20.0.4
Python-PostgreSQL Database Adapter: psycopg2==2.8.6


See you, VHS.