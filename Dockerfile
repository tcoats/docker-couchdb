FROM debian:jessie
MAINTAINER Thomas Coats <docker@voodoolabs.net>

ENV COUCHDB_VERSION=1e25dc1

ADD . /install/
RUN /install/install.sh

EXPOSE 5984 15984 25984 35984 15986 25986 35986
ENTRYPOINT ["/usr/src/couchdb/dev/run"]
CMD ["--with-admin-party-please", "-n", "1", "--with-haproxy"]
