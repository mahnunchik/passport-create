# passport-create

[Passport](http://passportjs.org/) strategy for creating new user if unauthenticated.

This module lets you create new users on first visit. By plugging into Passport, `create` authentication 
can be easily and unobtrusively integrated into any application or framework that supports
[Connect](http://www.senchalabs.org/connect/)-style middleware, including
[Express](http://expressjs.com/).

## Install

    $ npm install passport-create

## Usage

#### Configure Strategy

The strategy requires a `create` callback, which calls `done` providing a user.

    passport.use(new CreateStrategy(
      function(done) {
        User.create({ username: username }, function (err, user) {
          if (err) { return done(err); }
          if (!user) { return done(null, false); }
          return done(null, user);
        });
      }
    ));

#### Authenticate Requests

Use `passport.authenticate()`, specifying the `'create'` strategy, to
authenticate requests.

For example, as middleware in an [Express](http://expressjs.com/)
application:
    
    app.use(passport.authenticate('create'));

#### Options:
  - `passReqToCallback`   when `true`, `req` is the first argument to the create callback (default: `false`)

## Tests

    $ npm install -d
    $ npm test

## Inspired by

  - [Jared Hanson](http://github.com/jaredhanson)
  - [Passport](http://passportjs.org/)
  - [Passport-dummy](https://npmjs.org/package/passport-dummy)

## License

(The MIT License)

Copyright (c) 2013 Eugeny Vlasenko <mahnunchik@gmail.com>

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