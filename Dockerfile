FROM ubuntu:18.04

RUN apt update && apt install -y && \
    wget && \
    curl && \
    ssh && \
    git && \
    tar && \
    mysql-client && \
    make && \
    golang && \
    rm -r /var/lib/apt/lists/*

RUN mkdir -p /root/.kube

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && chmod +x ./kubectl && mv ./kubectl /usr/local/bin/kubectl
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 && chmod 700 get_helm.sh && ./get_helm.sh && rm ./get_helm.sh

RUN mkdir /root/.ssh && \
    touch /root/.ssh/known_hosts && \
    ssh-keyscan bitbucket.org >> /root/.ssh/known_hosts && \
    ssh-keyscan github.com >> /root/.ssh/known_hosts

RUN curl -L https://github.com/drone/drone-cli/releases/latest/download/drone_linux_amd64.tar.gz | tar zx && install -t /usr/local/bin drone && \
    rm ./drone
