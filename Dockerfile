FROM fedora:39
LABEL maintainer="Preston Davis pdavis@redhat.com"
USER root

# Install packages
RUN yum install -y zsh git wget ripgrep fd-find fontconfig tldr neovim lsof net-tools && yum -y autoremove && yum clean all

# terminal colors with xterm
ENV TERM xterm256

# user home dir
ENV HOME=/home/pdavis
# set working directory

WORKDIR $HOME

# Install cheat.sh
RUN mkdir -p ~/bin/ && curl https://cht.sh/:cht.sh > ~/bin/cht.sh && chmod +x ~/bin/cht.sh

# Copy Hack font into container
RUN rm -f /home/pdavis/.local/share/fonts/*
COPY /src/complete/* /home/pdavis/.local/share/fonts/

# Refresh system font cache
RUN fc-cache -f -v

# Install SpaceVIM
#RUN curl -sLf https://spacevim.org/install.sh | bash

# Install oh-my-zsh
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true

# set the zsh theme
ENV ZSH_THEME=agnoster

# Set ls aliases
RUN echo alias ll="exa -l -g --icons" >> /home/pdavis/.zshrc
RUN echo alias lla="exa -l -a -g --icons" >> /home/pdavis/.zshrc
RUN echo alias ls="exa --icons" >> /home/pdavis/.zshrc

# set default terminal to zsh
CMD ["zsh"]
