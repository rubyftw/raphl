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

## License

The MIT License (MIT)

Copyright (c) 2013 Phillip Ridlen

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.


