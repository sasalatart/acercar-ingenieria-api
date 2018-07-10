# Acercar Ingeniería API

## About

API built on top of Ruby on Rails for a project of the Centro de Alumnos de Ingeniería UC (CAi) that started in 2014 because of a detected need of new students to approach the professional reality of Engineering. This project seeks to gather in the same portal articles, news, videos, research and interesting projects so that students can make a better decision about what Major to follow.

## Technologies and Services Used

- Ruby 2.4
- Rails 5.2
- PostgreSQL 10 (including full text search via `pg_search` gem)
- Redis 4 (for background processing via `sidekiq` gem)
- Mailgun (mailing API)
- Digital Ocean Spaces (cloud storage)
- Pusher (real-time features)

## Development Setup

1. Clone and cd into this repository.
2. Make sure to have [Ruby](https://rvm.io/), [PostgreSQL](https://www.postgresql.org/) and [Redis](https://redis.io/) on your machine.
3. Make sure to have [Mailcatcher](https://github.com/sj26/mailcatcher) (or similar) running for email debugging.
4. Make sure to have [ImageMagick](https://github.com/ImageMagick/ImageMagick) installed for image processing.
5. Run `bundle install` to install ruby dependencies.
6. Setup the database by running `rails db:reset`. You can additionally use the `EXTENDED=true` env variable to seed with extra random users, articles, discussions, etc. If this env variable is not used, the seeds will add the minimum data required to release the app in production.
7. Run `rails s -p 3001` to run the application on port 3001.
8. Run `bundle exec sidekiq` in the same dir, but in a new shell to start Sidekiq.

If you wish to use real-time features, you will also need to export your Pusher credentials environment variables, as explained in the next section.

## Docker (Compose) Setup

First, make sure to rename the file `.env.example` to `.env`, and complete it with the following environment variables in the form of `KEY=VALUE`:

<table>
  <tr>
    <th>ENV Variables</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>API_HOST</td>
    <td rowspan="2">host and port for the API</td>
  </tr>
  <tr><td>API_PORT</td></tr>
  <tr>
    <td>SECRET_KEY_BASE</td>
    <td>for verifying the integrity of signed cookies</td>
  </tr>
  <tr>
    <td>MAILGUN_DOMAIN</td>
    <td rowspan="2">your Mailgun credentials</td>
  </tr>
  <tr><td>MAILGUN_API_KEY</td></tr>
  <tr>
    <td>MAINTAINER_EMAIL</td>
    <td>target email for exception notifications</td>
  </tr>
  <tr>
    <td>SPACES_ACCESS_KEY</td>
    <td rowspan="4">your Digital Ocean Spaces credentials</td>
  </tr>
  <tr><td>SPACES_SECRET_KEY</td></tr>
  <tr><td>SPACES_REGION</td></tr>
  <tr><td>SPACES_BUCKET</td></tr>
  <tr>
    <td>SIDEKIQ_USERNAME</td>
    <td rowspan="2">custom credentials for accessing Sidekiq UI</td>
  </tr>
  <tr><td>SIDEKIQ_PASSWORD</td></tr>
  <tr>
    <td>PUSHER_APP_ID</td>
    <td rowspan="4">your Pusher credentials</td>
  </tr>
  <tr><td>PUSHER_KEY</td></tr>
  <tr><td>PUSHER_SECRET</td></tr>
  <tr><td>PUSHER_CLUSTER</td></tr>
  <tr>
    <td>WS_ENABLED</td>
    <td>whether or not you want to activate real-time features (true/false)</td>
  </tr>
</table>

You can visit https://www.mailgun.com/, https://www.digitalocean.com/ and https://pusher.com/ to get your Mailgun, Digital Ocean Spaces and Pusher credentials.

Then, run the following commands:

```sh
# Run the app (backend, frontend & databases)
$ docker-compose up -d

# Setup the database
$ docker-compose exec acercarapi rails db:reset
```

You should now be able to:

- Access the web client via http://0.0.0.0:5000/

- Access API endpoints via http://0.0.0.0:3001/

- Access Sidekiq UI via http://0.0.0.0:3001/sidekiq

__You must take into account the fact that the [Frontend Docker Image](https://github.com/sasalatart/acercar-ingenieria-client) needs to be built considering the API's URL, as well as your Pusher credentials.__

## Production

1) Make sure to have https enabled.

2) You can setup custom domain names by adding `nginx-proxy` to the Docker composition:

```sh
services:
  ...

  proxy:
    image: jwilder/nginx-proxy
    restart: always
    volumes:
      - /var/run/docker.sock:/tmp/docker.sock:ro
    ports:
      - 443:443
```

Also, you should remember to add the corresponding virtual hosts to each service. For example:

```sh
  acercarapi:
    ...
    environment:
      VIRTUAL_HOST: api.acercaringenieria.cl
      VIRTUAL_PORT: 3000

  acercarclient:
    environment:
      VIRTUAL_HOST: acercaringenieria.cl
      VIRTUAL_PORT: 5000
```

## Credits

Some of the assets used in the project are licensed as Creative Commons CCBY, from [The Noun Project](https://thenounproject.com/). These are:

- [Analysis](https://thenounproject.com/term/analysis/588602/) by Artem Kovyazin
- [Architecture](https://thenounproject.com/term/architecture/354603/) by John T. Garcia
- [Article](https://thenounproject.com/term/article/1091930/) by Creative Stall
- [Chemistry](https://thenounproject.com/term/chemistry/465908/) by Rockicon
- [Computer](https://thenounproject.com/term/computer/1688783/) by Susannanova
- [Construction](https://thenounproject.com/term/construction/141949/) by Sergey Novosyolov
- [Construction Manager](https://thenounproject.com/term/construction_manager/881227/) by by Gan Khoon Lay
- [DNA](https://thenounproject.com/term/dna/96527/) by Lloyd Humphreys
- [Environment](https://thenounproject.com/term/environment/1458371/) by Becris
- [Environmental](https://thenounproject.com/term/environmental/1091773/) by Made
- [Gears](https://thenounproject.com/term/gears/200525/) by Alexander Skowalsky
- [Geode](https://thenounproject.com/term/geode/18107/) by Drue McCurdy
- [Innovation](https://thenounproject.com/term/innovation/447435/) by Gregor Cresnar
- [Pi](https://thenounproject.com/term/pi/607391/) by Davo Sime
- [Pickaxe](https://thenounproject.com/term/pickaxe/1404159/) by Creaticca Creative Agency
- [Robot](https://thenounproject.com/term/robot/960157/) by Creaticca Creative Agency
- [Rock](https://thenounproject.com/term/rock/5846/) by Anuar Zhumaev
- [School](https://thenounproject.com/term/school/1276289/) by AliWijaya
- [Transmission Tower](https://thenounproject.com/term/transmission_tower/4747/) by Olivier Guin
- [Transport](https://thenounproject.com/term/transport/1352224/) by Made
- [User](https://thenounproject.com/term/user/1688840/) by Alena Artemova
- [Waves](https://thenounproject.com/term/waves/1352914/) by Natasja Buer Toldam
- [X Ray](https://thenounproject.com/term/x_ray/1066122/) by H Alberto Gongora

If you wish to use them, you must give credit to their authors.
