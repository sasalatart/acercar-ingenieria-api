# Acercar Ingeniería API

## About

API built on top of Ruby on Rails for a project of the Centro de Alumnos de Ingeniería UC (CAi) that started in 2014 because of a detected need of new students to approach the professional reality of Engineering. With a new curriculum come new challenges, and the wide variety of opportunities that are currently offered to students according to their interests and abilities can sometimes confuse and disorient them. This project seeks to gather in the same portal articles, news, videos, research and interesting projects so that students can make a better decision about what Major to follow.

## Technologies Used

- Ruby 2.4
- Ruby on Rails 5.1.4
- PostgreSQL 10 (including full text search via `pg_search` gem)
- Mailgun (mailing API)
- Cloudinary (cloud storage)

## Development Setup

1. Clone and cd into this repository.
2. Make sure to have both [Ruby](https://rvm.io/) and [PostgreSQL](https://www.postgresql.org/) on your machine.
3. Make sure to have [Mailcatcher](https://github.com/sj26/mailcatcher) (or similar) running for email debugging.
4. Make sure to have [ImageMagick](https://github.com/ImageMagick/ImageMagick) installed for image processing.
5. Run `bundle install` to install ruby dependencies.
6. Setup the database by running `rails db:reset`.
7. Run `rails s -p 3001` to run the application on port 3001.

## Docker Setup

First, make sure to have a file called `.env.list` with the following environment variables in the form of `KEY=VALUE`:

<table>
  <tr>
    <th>ENV Variables</th>
    <th>Description</th>
  </tr>
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
    <td>API_HOST</td>
    <td rowspan="2">host and port for the API</td>
  </tr>
  <tr><td>API_PORT</td></tr>
</table>

You can visit https://www.mailgun.com/ and https://cloudinary.com/ to get your Mailgun and Cloudinary credentials.

Then, run the following commands:

```sh
# Run the database
$ docker run -d --name=postgres_db postgres:10.0

# Run the API
$ docker run -d --name=acercarapi -p 3000:3000 --env-file ./.env.list \
             --link=postgres_db:postgres_db sasalatart/acercar-ingenieria-api

# Setup the database
$ docker exec acercarapi rails db:reset
```

The server's machine should now be redirecting its port 3000 to the container's port 3000.


## Frontend APP

React frontend app can be found [in this repo](https://github.com/sasalatart/acercar-ingenieria-client).
