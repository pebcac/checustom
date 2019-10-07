# FROM registry.access.redhat.com/codeready-workspaces/stacks-java:latest
FROM fedora:latest
USER root
RUN curl -LO https://github.com/openshift/origin/releases/download/v3.11.0/openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz && tar xvf openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz
RUN mv openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit/oc /usr/local/bin/oc && chmod +x /usr/local/bin/oc
RUN curl -L https://github.com/openshift/odo/releases/latest/download/odo-linux-amd64 -o /usr/local/bin/odo && chmod +x /usr/local/bin/odo
# RUN echo $'[centos]\nname=CentOS-7\nbaseurl=http://distro.ibiblio.org/centos/7.6.1810/os/x86_64/\nenabled=1 \ngpgcheck=0'>> /etc/yum.repos.d/centos.repo
RUN yum install -y zsh
RUN yum update -y && yum -y autoremove && yum clean all
# terminal colors with xterm
ENV TERM xterm
# set the zsh theme 
ENV ZSH_THEME agnoster
# Install oh-my-zsh
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
# set default terminal to zsh
CMD ["zsh"]
