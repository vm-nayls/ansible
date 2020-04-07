FROM python:3.7-slim-stretch

WORKDIR /ansible
RUN apt-get update && apt-get upgrade -y \
    \
    && apt-get install -y \
        gnupg2 \
        openssh-client \
        ca-certificates \
        openssl \
    \
    && apt-get install -y \
        libssl-dev \
        libffi-dev \
        python3-dev \
    \
    && python3.7 -m pip install "ansible>=2.9,<3.0" jmespath prettytable \
    \
    && apt-get remove -y \
        libssl-dev \
        libffi-dev \
        python3-dev \
    && rm -rf /tmp/* \
    && rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN ln -s /docker-entrypoint.sh /usr/local/bin/docker-entrypoint

STOPSIGNAL SIGTERM
ENTRYPOINT ["docker-entrypoint"]
CMD ["ansible-playbook"]