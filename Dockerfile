# FROM registry.access.redhat.com/codeready-workspaces/stacks-java:latest
FROM centos:latest
MAINTAINER Preston Davis (pdavis@redhat.com)
USER root
RUN curl -L https://github.com/openshift/odo/releases/latest/download/odo-linux-amd64 -o /usr/local/bin/odo && chmod +x /usr/local/bin/odo
RUN yum install -y zsh podman podman-docker git wget fontawesome-fonts
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
