#!/bin/ash

set -eo pipefail

if [ "$1" = 'ansible-playbook' ]; then
    eval "$(ssh-agent -s)"

    mkdir -p ~/.ssh
    chmod 700 ~/.ssh

    $(echo "${SSH_PRIVATE_KEY}" | tr -d '\r' | ssh-add - ) || $(echo "${SSH_PRIVATE_KEY}" | base64 -d | tr -d '\r' | ssh-add - )
fi

exec "$@"