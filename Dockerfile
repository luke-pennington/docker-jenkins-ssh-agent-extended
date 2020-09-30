FROM jenkinsci/ssh-slave:latest
LABEL maintainer="Bernd Meyer <be.me@posteo.de>"

# install Git, curl and Docker (client only)
RUN apt-get update && apt-get install --no-install-recommends -y \
    apt-transport-https \
    ca-certificates \
    curl \
    git \
    gnupg2 \
    software-properties-common \
    && curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -\
    && add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/debian \
    $(lsb_release -cs) \
    stable" \
    && apt-get update && apt-get install -y \
    docker-ce-cli \
    && rm -rf /var/lib/apt/lists/*

RUN addgroup docker \
    && usermod -aG docker jenkins
