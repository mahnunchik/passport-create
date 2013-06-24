/**
* Module dependencies.
*/
var passport = require('passport')
, util = require('util');


/**
*
* `Strategy` constructor.
*
* The `create` authentication strategy call `create` callback if unauthenticated and authenticates requests.
*
* Applications must supply a `create` callback which calls the `done` callback 
* supplying a `user`, which should be set to `false` if something went wrong.
* If an exception occured, `err` should be set.
*
* Options:
*   - `passReqToCallback`   when `true`, `req` is the first argument to the create callback (default: `false`)
*
* Examples:
*
*   passport.use(new CreateStrategy(
*     function(done) {
*     var user = { username: 'dummy' }
*       done(null, user);
*     }
*   ));
*
* @param {Object} options
* @param {Function} create
* @api public
*/
function Strategy(options, create) {
  if (typeof options == 'function') {
    create = options;
    options = {};
  }
  if (!create) throw new Error('create authentication strategy requires a create function');

  passport.Strategy.call(this);
  this.name = 'create';
  this._create = create;
  this._passReqToCallback = options.passReqToCallback;
}

/**
* Inherit from `passport.Strategy`.
*/
util.inherits(Strategy, passport.Strategy);

/**
* Authenticate request.
*
* @param {Object} req
* @api protected
*/
Strategy.prototype.authenticate = function(req) {
  if(req.isUnauthenticated()){
    var self = this;
    function done(err, user, info) {
      if (err) { return self.error(err); }
      if (!user) { return self.fail(info); }
      self.success(user, info);
    }

    if (this._passReqToCallback) {
      this._create(req, done);
    } else {
      this._create(done);
    }
  }else{
    this.pass()
  }
}


/**
* Expose `Strategy`.
*/ 
module.exports = Strategy;
