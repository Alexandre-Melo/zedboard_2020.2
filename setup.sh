#!/usr/bin/env bash

set -e

# Global definitions
CWD="$(pwd)"

dockername="zedbuild"

# Checks if docker is installed and exit otherwise
DOCKER_USAGE=$(cat <<-END
	Error: could not find docker.
	END
	)
if ! [ "$(command -v docker)" ]; then
	echo "${DOCKER_USAGE}" >&2
	exit 1
fi

machine_check() {
    if [[ "$(docker images -q ${dockername} 2> /dev/null)" == "" ]]; then
        return 1
    else
        return 0
    fi
}

machine_build() {
    docker build \
        --build-arg "host_uid=$(id -u)" \
        --build-arg "host_gid=$(id -g)" \
        --tag ${dockername} -f Dockerfile .
}

machine_execute() {
    docker run \
        -it \
        --rm \
        -v "$1"/:/home/auser/yocto/ \
        ${dockername} /bin/bash
}

if ! machine_check ; then
    echo "Docker image ${dockername} does not exist."
 	echo "Creating ${dockername} image."
    machine_build 
elif [ -n "$force" ]; then
    echo "Triggering ${dockername} docker image rebuild."
    machine_build 
fi

machine_execute "${CWD}" 

