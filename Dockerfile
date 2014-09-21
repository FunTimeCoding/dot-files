FROM debian:wheezy
MAINTAINER Alexander Reitzel <funtimecoding@gmail.com>

RUN apt-get update
RUN apt-get upgrade -yq
RUN apt-get install -yq zsh git vim curl tmux openssh-server python-pip
RUN useradd -m -g sudo -s /bin/zsh areitzel
RUN echo "test\ntest" | passwd areitzel

USER areitzel
WORKDIR /home/areitzel
RUN git clone git://github.com/robbyrussell/oh-my-zsh.git .oh-my-zsh
RUN git clone git://github.com/FunTimeCoding/dotfiles.git .dotfiles
RUN git clone https://www.github.com/lokaltog/powerline.git .local/powerline
RUN ./.dotfiles/setup.sh

USER root
RUN mkdir /var/run/sshd
CMD ["/usr/sbin/sshd", "-D"]
EXPOSE 22
