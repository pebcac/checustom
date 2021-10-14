FROM fedora:latest
LABEL maintainer="Preston Davis pdavis@redhat.com"
USER root
RUN yum install -y zsh nfs-utils podman podman-docker git maven java-1.8.0-openjdk wget golang fontawesome-fonts vim-enhanced lsof htop net-tools
RUN yum update -y && yum -y autoremove && yum clean all
# terminal colors with xterm
ENV TERM xterm
# user home dir
ENV HOME=/home/pdavis
# set working directory
WORKDIR $HOME
# Install cheat.sh
RUN mkdir -p ~/bin/ && curl https://cht.sh/:cht.sh > ~/bin/cht.sh && chmod +x ~/bin/cht.sh
# Install SpaceVIM
RUN curl -sLf https://spacevim.org/install.sh | bash
# Make go working dir
RUN mkdir -p /home/pdavis/workspace/go
# Export GOPATH
ENV export GOPATH=/home/pdavis/workspace/go
# Install oh-my-zsh
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
# set the zsh theme
ENV ZSH_THEME=robbyrussell
# set default terminal to zsh
CMD ["zsh"]
