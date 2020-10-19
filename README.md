V073 - Web Ballots
==================

[![Build Status](https://travis-ci.org/v073/v073.svg?branch=main)](https://travis-ci.org/v073/v073)

## System requirements

| Package/Module | Version |
|----------------|---------|
| [perl][perl] | >= 5.20 |
| [DBD::SQLite][sqlite] | 1.64 |
| [DBIx::Class][dbic] | 0.08 |
| [DBIx::Class::Schema::Loader][dbic-sl] | 0.07 |
| [Mojolicious][mojo] | 8.58 |

### Best practice

Install perl with your favourite package handler or via [perlbrew][perlbrew], install [cpanm][cpanm] to manage perl modules and install the module dependencies via

```
$ cpanm -n --installdeps .
```

[perl]: https://www.perl.org/get.html
[sqlite]: https://metacpan.org/pod/DBD::SQLite
[dbic]: https://metacpan.org/pod/DBIx::Class
[dbic-sl]: https://metacpan.org/pod/DBIx::Class::Schema::Loader
[mojo]: https://metacpan.org/pod/Mojolicious
[perlbrew]: https://perlbrew.pl/
[cpanm]: https://metacpan.org/pod/App::cpanminus

## Configuration

Edit [`config.yml`](config.yml) as a user-friendly configuration file.

## Deployment

v073's [backend](backend) is a standard Mojolicious app and can be [deployed for production][deploy] using its built-in server [hypnotoad][hypnotoad]:

```bash
$ hypnotoad script/backend
```

### Docker deployment

```bash
$ docker build -t v073 .
$ docker run -tip 8000:4000 -e PORT=4000 v073
```

[deploy]: https://docs.mojolicious.org/Mojolicious/Guides/Cookbook#DEPLOYMENT
[hypnotoad]: https://docs.mojolicious.org/Mojolicious/Guides/Cookbook#Hypnotoad

## Author and License

Copyright (c) [Mirko Westermeier][mirko] ([\@memowe][mgh], [mirko@westermeier.de][mmail])

Released under the MIT (X11) license. See [LICENSE][mit] for details.

[mirko]: http://mirko.westermeier.de
[mgh]: https://github.com/memowe
[mmail]: mailto:mirko@westermeier.de
[mit]: LICENSE
