FROM ubuntu:18.04

RUN apt update && apt install -y \
    wget \
    curl \
    ssh \
    rsync \
    git \
    tar \
    mysql-client \
    make \
    software-properties-common \
    python-pip \
    jq \
    docker \
    golang && \
    rm -r /var/lib/apt/lists/*

RUN add-apt-repository ppa:eugenesan/ppa && apt update && apt install -y jq unzip && \
    rm -r /var/lib/apt/lists/*

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install

RUN curl https://raw.githubusercontent.com/silinternational/ecs-deploy/master/ecs-deploy | tee -a /usr/bin/ecs-deploy
RUN chmod +x /usr/bin/ecs-deploy

RUN mkdir -p /root/.kube

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && chmod +x ./kubectl && mv ./kubectl /usr/local/bin/kubectl
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 && chmod 700 get_helm.sh && ./get_helm.sh && rm ./get_helm.sh

RUN mkdir /root/.ssh && \
    touch /root/.ssh/known_hosts && \
    ssh-keyscan bitbucket.org >> /root/.ssh/known_hosts && \
    ssh-keyscan github.com >> /root/.ssh/known_hosts

RUN curl -L https://github.com/drone/drone-cli/releases/latest/download/drone_linux_amd64.tar.gz | tar zx && install -t /usr/local/bin drone && \
    rm ./drone

COPY ./drone-docker-build.sh ./drone-docker-build.sh
