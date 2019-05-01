FROM jenkinsci/ssh-slave:latest
LABEL maintainer="Bernd Meyer <be.me@posteo.de>"

ENV GIT_VERSION=1:2.11.0-3+deb9u4
ENV CURL_VERSION=7.52.1-5+deb9u9
ENV DOCKER_CE_CLI=5:18.09.0~3-0~debian-stretch

# install Git, curl and Docker (client only)
RUN apt-get update && apt-get install --no-install-recommends -y \
    apt-transport-https \
    ca-certificates \
    curl=${CURL_VERSION} \
    git=${GIT_VERSION} \
    gnupg2 \
    software-properties-common \
    && curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -\
    && add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/debian \
    $(lsb_release -cs) \
    stable" \
    && apt-get update && apt-get install -y \
    docker-ce-cli=${DOCKER_CE_CLI} \
    && rm -rf /var/lib/apt/lists/*

RUN addgroup docker \
    && usermod -aG docker jenkins
