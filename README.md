# Suport tag

```bash
docker pull registry.gitlab.com/nayls-cloud/ansible:<tag>
```

* v2.9
  * [`2.9-python3.7-alpine3.10`, (Dockerfile)](https://registry.gitlab.com/nayls-cloud/ansible/blob/master/2.9/python3.7/alpine3.10/Dockerfile)
  * [`2.9-python3.7-alpine3.11`, (Dockerfile)](https://registry.gitlab.com/nayls-cloud/ansible/blob/master/2.9/python3.7/alpine3.11/Dockerfile)
  * [`2.9-python3.7-slim-stretch`, (Dockerfile)](https://registry.gitlab.com/nayls-cloud/ansible/blob/master/2.9/python3.7/slim-stretch/Dockerfile)
  * [`2.9-python3.7-slim-buster`, (Dockerfile)](https://registry.gitlab.com/nayls-cloud/ansible/blob/master/2.9/python3.7/slim-buster/Dockerfile)
  * [`2.9-python3.8-alpine3.10`, (Dockerfile)](https://registry.gitlab.com/nayls-cloud/ansible/blob/master/2.9/python3.8/alpine3.10/Dockerfile)
  * [`2.9-python3.8-alpine3.11`, (Dockerfile)](https://registry.gitlab.com/nayls-cloud/ansible/blob/master/2.9/python3.8/alpine3.11/Dockerfile)
  * [`2.9-python3.8-slim-buster`, (Dockerfile)](https://registry.gitlab.com/nayls-cloud/ansible/blob/master/2.9/python3.8/slim-buster/Dockerfile)

# Build

```bash
DOCKER_BUILDKIT=1 make build
# or
DOCKER_BUILDKIT=1 ANSIBLE_VERSION=2.9 PYTHON_VERSION=python3.8 OC_VERSION=alpine3.11 make build
```

# How to Use

```bash
docker run -e "SSH_PRIVATE_KEY=`cat ~/.ssh/id_rsa`" registry.registry.gitlab.com/nayls-cloud/ansible:2.9-python3.8-alpine3.11
```