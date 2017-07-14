FROM debian:stretch
MAINTAINER Alexander Reitzel <funtimecoding@gmail.com>

RUN apt-get update
RUN apt-get upgrade -yq
RUN apt-get install -yq zsh git vim curl tmux openssh-server python-pip php5-cli
RUN useradd -m -g sudo -s /bin/zsh areitzel
RUN echo "example\nexample" | passwd areitzel

USER areitzel
WORKDIR /home/areitzel
RUN mkdir src
RUN git clone git://github.com/robbyrussell/oh-my-zsh.git src/oh-my-zsh
RUN git clone git://github.com/FunTimeCoding/dot-files.git src/dot-files
RUN ./src/dot-files/setup.sh

USER root
RUN mkdir /var/run/sshd
CMD ["/usr/sbin/sshd", "-D"]
EXPOSE 22
