# FROM registry.access.redhat.com/codeready-workspaces/stacks-java:latest
FROM centos:latest
MAINTAINER Preston Davis (pdavis@redhat.com)
USER root
RUN curl -LO https://github.com/openshift/origin/releases/download/v3.11.0/openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz && tar xvf openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz
RUN mv openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit/oc /usr/local/bin/oc && chmod +x /usr/local/bin/oc
RUN curl -L https://github.com/openshift/odo/releases/latest/download/odo-linux-amd64 -o /usr/local/bin/odo && chmod +x /usr/local/bin/odo
RUN curl -LO https://get.helm.sh/helm-v2.15.1-linux-amd64.tar.gz && tar xvf helm-v2.15.1-linux-amd64.tar.gz
RUN mv linux-amd64/helm /usr/local/bin/helm && chmod +x /usr/local/bin/helm
RUN mv linux-amd64/tiller /usr/local/bin/tiller && chmod +x /usr/local/bin/tiller
RUN yum install -y zsh podman podman-docker git wget fontawesome-fonts htop
RUN yum update -y && yum -y autoremove && yum clean all
# terminal colors with xterm
ENV TERM xterm
# user home dir
ENV HOME=/root
# set working directory
WORKDIR $HOME
# Install oh-my-zsh
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
# set the zsh theme
ENV ZSH_THEME=robbyrussell
# set default terminal to zsh
CMD ["zsh"]
