# Raphl

Raffle anything! It doesn't matter what it is.

## Requirements

  * Ruby (>= 1.9.3)
  * Redis
  * For RubyGem dependencies, see the [Gemfile](Gemfile)

## Usage

### Setup

Redis installed and running on the default host/port or set a `REDIS_URL` environment variable
pointing to your Redis instance.

Install gem dependencies with [Bundler](http://gembundler.com):

```bash
$ bundle install
```

Start the web server, and you're done!

```bash
$ bundle exec thin -R config.ru
>> Thin web server (v1.5.1 codename Straight Razor)
>> Maximum connections set to 1024
>> Listening on 0.0.0.0:3000, CTRL+C to stop
```

### Interface

To set up a new Raffle, pick a code that hasn't been used before, and visit
`http://localhost:3000/:code` to see the entry form. The endpoints are as follows:

  * `GET` `/:code` - Entry form
  * `POST` `/:code/enter` - Submit entry form. Parameters for entry are `email`, `raffle`, and
    `terms`.
  * `GET` `/:code/entries` - View all entries
  * `GET` `/:code/winner` - Pick a winner and highlight it in the list of entries

## Demo

There is a demo running on Heroku at <http://raphl.herokuapp.com>.


