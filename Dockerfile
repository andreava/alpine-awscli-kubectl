FROM alpine:latest

ARG DOCKER_CLI_VERSION="17.06.2-ce"
ENV DOCKER_DOWNLOAD_URL="https://download.docker.com/linux/static/stable/x86_64/docker-$DOCKER_CLI_VERSION.tgz"

ARG KUBECTL_CLI_VERSION="v1.17.0"
ENV KUBECTL_DOWNLOAD_URL="https://storage.googleapis.com/kubernetes-release/release/$KUBECTL_CLI_VERSION/bin/linux/amd64/kubectl"



RUN apk update \
    && apk add --no-cache tini \
    && apk add --no-cache curl \
    && apk add --no-cache curl jq python py-pip git \
    && pip install awscli


#RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl

RUN curl -LO $KUBECTL_DOWNLOAD_URL \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/kubectl

RUN mkdir -p /tmp/download \
    && curl -L $DOCKER_DOWNLOAD_URL | tar -xz -C /tmp/download \
    && mv /tmp/download/docker/docker /usr/local/bin/ \
    && rm -rf /tmp/download \