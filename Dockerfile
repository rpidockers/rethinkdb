FROM resin/rpi-raspbian:jessie

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y git-core g++ nodejs npm libprotobuf-dev libgoogle-perftools-dev libncurses5-dev libboost-all-dev nodejs-legacy curl libcurl3 libcurl4-openssl-dev protobuf-compiler

RUN \
    git clone --depth 1 -b v1.15.x https://github.com/rethinkdb/rethinkdb.git /tmp/rethinkdb && \
    cd /tmp/rethinkdb && \
    ./configure --allow-fetch && \
    make && \
    mv build/release /opt/rethinkdb && \
    cd / && \
    rm -rf /tmp/rethinkdb


EXPOSE 8080
EXPOSE 28015
EXPOSE 29015

WORKDIR /data
VOLUME /data

CMD /opt/rethinkdb/rethinkdb --bind all
