FROM debian:testing-slim

RUN apt update

# JS/Node/npm
RUN apt install -y npm

# Perl debian packages
RUN apt install -y perl
RUN apt install -y libdbd-sqlite3-perl
RUN apt install -y libdbix-class-perl
RUN apt install -y libdbix-class-schema-loader-perl
RUN apt install -y libmojolicious-perl
RUN apt install -y liblocal-lib-perl

# CPAN dependencies
RUN apt install -y cpanminus
RUN cpanm -n Mojolicious::Plugin::Webpack

WORKDIR /v073
COPY . .

CMD perl backend daemon --listen http://*:$PORT
