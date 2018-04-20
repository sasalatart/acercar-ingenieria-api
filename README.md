# Acercar Ingeniería API

## About

API built on top of Ruby on Rails for a project of the Centro de Alumnos de Ingeniería UC (CAi) that started in 2014 because of a detected need of new students to approach the professional reality of Engineering. This project seeks to gather in the same portal articles, news, videos, research and interesting projects so that students can make a better decision about what Major to follow.

## Technologies Used

- Ruby 2.4
- Rails 5.1.4
- PostgreSQL 10 (including full text search via `pg_search` gem)
- Redis 4 (for background processing via `sidekiq` gem)
- Mailgun (mailing API)
- Cloudinary (cloud storage)
- Pusher (real-time features)

## Development Setup

1. Clone and cd into this repository.
2. Make sure to have [Ruby](https://rvm.io/), [PostgreSQL](https://www.postgresql.org/) and [Redis](https://redis.io/) on your machine.
3. Make sure to have [Mailcatcher](https://github.com/sj26/mailcatcher) (or similar) running for email debugging.
4. Make sure to have [ImageMagick](https://github.com/ImageMagick/ImageMagick) installed for image processing.
5. Run `bundle install` to install ruby dependencies.
6. Setup the database by running `rails db:reset`.
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
    <td>CLOUDINARY_CLOUD_NAME</td>
    <td rowspan="3">your Cloudinary credentials</td>
  </tr>
  <tr><td>CLOUDINARY_API_KEY</td></tr>
  <tr><td>CLOUDINARY_API_SECRET</td></tr>
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

You can visit https://www.mailgun.com/, https://cloudinary.com/ and https://pusher.com/ to get your Mailgun, Cloudinary and Pusher credentials.

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
      VIRTUAL_HOST: acercar-api.salatart.com
      VIRTUAL_PORT: 3000

  acercarclient:
    environment:
      VIRTUAL_HOST: acercaringenieria.salatart.com
      VIRTUAL_PORT: 5000
```
