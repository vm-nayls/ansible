# Suport tag

```bash
docker pull naylscloud/ansible:<tag>
```

* v2.10
  * [ `2.10-latest`, `2.10-alpine3.12`, `2.10-python3.9-alpine3.12`, (Dockerfile)](https://github.com/nayls-cloud/ansible/blob/master/2.10/python3.9/alpine3.12/Dockerfile)
  * [ `2.10-slim-buster`, `2.10-python3.9-slim-buster`, (Dockerfile)](https://github.com/nayls-cloud/ansible/blob/master/2.10/python3.9/slim-buster/Dockerfile)
  * [ `2.10-python3.8-alpine3.12`, (Dockerfile)](https://github.com/nayls-cloud/ansible/blob/master/2.10/python3.8/alpine3.12/Dockerfile)
  * [ `2.10-python3.8-slim-buster`, (Dockerfile)](https://github.com/nayls-cloud/ansible/blob/master/2.10/python3.8/slim-buster/Dockerfile)
* v2.9
  * [ `2.9-latest`, `2.9-alpine3.12`, `2.9-python3.9-alpine3.12`, (Dockerfile)](https://github.com/nayls-cloud/ansible/blob/master/2.9/python3.9/alpine3.12/Dockerfile)
  * [ `2.9-slim-buster`, `2.9-python3.9-slim-buster`, (Dockerfile)](https://github.com/nayls-cloud/ansible/blob/master/2.9/python3.9/slim-buster/Dockerfile)
  * [ `2.9-python3.8-alpine3.12`, (Dockerfile)](https://github.com/nayls-cloud/ansible/blob/master/2.9/python3.8/alpine3.12/Dockerfile)
  * [ `2.9-python3.8-slim-buster`, (Dockerfile)](https://github.com/nayls-cloud/ansible/blob/master/2.9/python3.8/slim-buster/Dockerfile)


# Build

```bash
DOCKER_BUILDKIT=1 make build
# or
DOCKER_BUILDKIT=1 ANSIBLE_VERSION=2.10 PYTHON_VERSION=python3.9 OC_VERSION=alpine3.12 make build
```

# How to Use

```bash
docker run -e "SSH_PRIVATE_KEY=`cat ~/.ssh/id_rsa`" registry.registry.gitlab.com/nayls-cloud/ansible:2.9-python3.8-alpine3.11
```