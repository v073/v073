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
| [Mojolicious::Plugin::Webpack][mojowp] | 0.13 |
| [npm][npm] | 6.14 |

[perl]: https://www.perl.org/get.html
[sqlite]: https://metacpan.org/pod/DBD::SQLite
[dbic]: https://metacpan.org/pod/DBIx::Class
[dbic-sl]: https://metacpan.org/pod/DBIx::Class::Schema::Loader
[mojo]: https://metacpan.org/pod/Mojolicious
[mojowp]: https://metacpan.org/pod/Mojolicious::Plugin::Webpack
[npm]: https://nodejs.org/en/download/
[perlbrew]: https://perlbrew.pl/
[cpanm]: https://metacpan.org/pod/App::cpanminus

## Configuration

Edit [`config.yml`](config.yml) as a user-friendly configuration file.

## Run the server

### For development

```bash
$ ./backend webpack
```

### Hypnotoad deployment

```bash
$ hypnotoad backend
```

### Docker deployment

```bash
$ docker build -t v073 .
$ docker run -tip 8000:4000 -e PORT=4000 v073
```

## Author and License

Copyright (c) [Mirko Westermeier][mirko] ([\@memowe][mgh], [mirko@westermeier.de][mmail])

Released under the MIT (X11) license. See [LICENSE][mit] for details.

[mirko]: http://mirko.westermeier.de
[mgh]: https://github.com/memowe
[mmail]: mailto:mirko@westermeier.de
[mit]: LICENSE
