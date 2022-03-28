FROM fedora:latest
LABEL maintainer="Preston Davis pdavis@redhat.com"
USER root

# Install packages
RUN yum install -y zsh git wget exa fontconfig tldr powerline-fonts golang vim-enhanced lsof htop net-tools && yum -y autoremove && yum clean all
# RUN yum update -y && yum -y autoremove && yum clean all

# terminal colors with xterm
ENV TERM xterm

# user home dir
ENV HOME=/home/pdavis
# set working directory

# Install Meslo Nerdfont
# ENV wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip && unzip Meslo.zip && cd Meslo && cp * ~/.local/share/fonts

WORKDIR $HOME

# Download and install the OpenShift OC client
RUN wget https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/stable/openshift-install-linux.tar.gz && tar zxvf openshift-install-linux.tar.gz
RUN mkdir ~/bin && mv oc kubectl ~/bin

# Install cheat.sh
RUN mkdir -p ~/bin/ && curl https://cht.sh/:cht.sh > ~/bin/cht.sh && chmod +x ~/bin/cht.sh

# Install SpaceVIM
RUN curl -sLf https://spacevim.org/install.sh | bash

# Copy Hack font into container
RUN rm -f /home/pdavis/.local/share/fonts/*
COPY /src/complete/* /home/pdavis/.local/share/fonts/ 

# Refresh system font cache
RUN fc-cache -f -v

# Make go working dir
RUN mkdir -p /home/pdavis/workspace/go

# Export GOPATH
ENV export GOPATH=/home/pdavis/workspace/go

# Install oh-my-zsh
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true

# set the zsh theme
ENV ZSH_THEME=agnoster

# Set ls aliases
RUN echo alias ll=\"exa -l -g --icons\" >> /home/pdavis/.zshrc 
RUN echo alias lla=\"exa -l -a -g --icons\" >> /home/pdavis/.zshrc 
RUN echo alias ls=\"exa --icons\" >> /home/pdavis/.zshrc

# set default terminal to zsh
CMD ["zsh"]
