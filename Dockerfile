FROM ubuntu:latest

RUN apt-get -y update
RUN apt-get -y install libev-dev libssl-dev automake python-docutils flex bison pkg-config

RUN mkdir /build
WORKDIR /build
ADD . .

RUN ./bootstrap
RUN ./configure --prefix=/usr/local/hitch
RUN make 
RUN make install

WORKDIR /usr/local/hitch
ADD etc /usr/local/hitch/etc
RUN useradd --system --no-create-home --shell /sbin/nologin hitch

CMD ["/usr/local/hitch/sbin/hitch", "--conf", "/usr/local/hitch/etc/hitch.cfg", "--user", "hitch", "--group", "hitch"]
