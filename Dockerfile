FROM archlinux/base

RUN pacman -Syu --noconfirm \
    awk \
    bash \
    fd \
    file \
    fzf \
    git \
    make \
    ranger \
    stow \
    sudo \
    tig \
    tmux \
    vim \
    xsel \
    zsh \
    && sed -ri 's/^# (%wheel.+NOPASSWD.+)$/\1/g' /etc/sudoers \
    && useradd -ms /bin/zsh arch \
    && gpasswd -a arch wheel

WORKDIR /home/arch

COPY --chown=arch:arch / dotfiles

ARG MAKE_EXTRA_ARGS=

RUN sudo -u arch make -f dotfiles/Makefile ${MAKE_EXTRA_ARGS}

USER arch

CMD [ "zsh" ]
