FROM tmaczukin/debian
MAINTAINER Tomasz Maczukin "tomasz@maczukin.pl"

RUN apt-get update # update_20150223180551
RUN apt-get install -y git-core build-essential \
                        zlib1g-dev libssl-dev libreadline-dev libyaml-dev \
                        libxml2-dev libxslt-dev libffi-dev sudo && \
                        apt-get clean

COPY assets/init /usr/local/bin/init
RUN chmod +x /usr/local/bin/init

RUN useradd -p rb -d /home/rb -m rb
RUN echo "rb  ALL=NOPASSWD: ALL" >> /etc/sudoers

USER rb
WORKDIR /home/rb

RUN git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

ENV CONFIGURE_OPTS --disable-install-doc

ENTRYPOINT ["/usr/local/bin/init"]
CMD ["/bin/bash"]
