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
5. Make sure you have access to the application's credentials, as explained in the next section.
6. Run `bundle install` to install ruby dependencies.
7. Setup the database by running `rails db:reset`. You can additionally use the `EXTENDED=true` env variable to seed with extra random users, articles, discussions, etc. If this env variable is not used, the seeds will add the minimum data required to release the app in production.
8. Run `rails s -p 3001` to run the application on port 3001.
9. Run `bundle exec sidekiq` in the same dir, but in a new shell to start Sidekiq.

## Credentials Setup

In order to use Mailgun, Digital Ocean Spaces, Pusher and access Sidekiq's dashboard, you need to have access to the encrypted credentials.

If you are going to use the ones in this project, just make sure that `RAILS_MASTER_KEY` env variable is available, and has the corresponding value.

If you wish to edit them, just run:

```sh
$ EDITOR=vim rails credentials:edit
```

The secrets that will be needed are:

```yml
secret_key_base:

sidekiq:
  username:
  password:

pusher:
  app_id:
  key:
  secret:
  cluster:

### production only ###

db_password: # must be the same as the postgres container's POSTGRES_PASSWORD env variable

mailgun:
  api_key:
  domain:

spaces:
  access_key:
  secret_key:
  region:
  bucket:
```

You can visit https://www.mailgun.com/, https://www.digitalocean.com/ and https://pusher.com/ to get your own Mailgun, Digital Ocean Spaces and Pusher credentials.

## Environment Variables Setup

The following is a list of environment variables that the application needs in order to work:

<table>
  <tr>
    <th>ENV Variables</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>RAILS_MASTER_KEY</td>
    <td>decrypts secret credentials</td>
  </tr>
  <tr>
    <td>API_HOST</td>
    <td>defaults to localhost in development, and https://api.acercaringenieria.cl in production</td>
  </tr>
  <tr>
    <td>API_PORT</td>
    <td>defaults to 3001 in development, and 443 in production</td>
  </tr>
  <tr>
    <td>MAINTAINER_EMAIL</td>
    <td>target email for exception notifications</td>
  </tr>
  <tr>
    <td>WS_ENABLED</td>
    <td>whether or not you want to activate real-time features (true/false)</td>
  </tr>
</table>

If you will be using the `docker-compose.yml` sample file in the project, make sure to rename the file `.env.example` to `.env`, and complete it with the missing values.

## Running With `docker-compose`

After completing the previous steps, run the following commands:

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

__You must take into account the fact that the [Frontend Docker Image](https://github.com/sasalatart/acercar-ingenieria-client) needs to be built considering the API's URL, as well as some of your Pusher credentials.__

## `docker-compose` in Production

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
