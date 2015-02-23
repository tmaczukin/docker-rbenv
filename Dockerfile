FROM debian:jessie
MAINTAINER Tomasz Maczukin "tomasz@maczukin.pl"

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update # update_20150223180551
RUN apt-get install -y --no-install-recommends git-core curl ca-certificates && apt-get clean

ENV TZ Europe/Warsaw
ENV LANG pl_PL.UTF-8

RUN apt-get install -y --no-install-recommends zlib1g-dev libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt-dev build-essential && apt-get clean

ADD init /init
RUN chmod +x /init

RUN useradd -p rb -d /home/rb -m rb
USER rb
WORKDIR /home/rb

RUN git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

ENV CONFIGURE_OPTS --disable-install-doc

ENTRYPOINT ["/init"]
CMD ["/bin/bash"]
