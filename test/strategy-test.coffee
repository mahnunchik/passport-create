assert = require 'assert'
CreateStrategy = require '../lib/passport-create/strategy'


describe 'CreateStrategy', ()->
  
  describe 'strategy', ()->    
    it 'should be named session', ()->
      strategy = new CreateStrategy ()->
      assert.equal strategy.name, 'create'
  
  describe 'strategy handling a request', ()->
    it 'strategy should call the callback', (done)->
      strategy = new CreateStrategy ()->
        done()
      req =
        isUnauthenticated: ()->
          return true
      process.nextTick ()->
        strategy.authenticate(req)

    it 'strategy should not call the callback', (done)->
      strategy = new CreateStrategy ()->
        throw new Error('strategy should not call the callback')
      strategy.pass = ()->
        done()
      req =
        isUnauthenticated: ()->
          return false
      process.nextTick ()->
        strategy.authenticate(req)

    it 'strategy should call the callback with req argument', (done)->
      strategy = new CreateStrategy {passReqToCallback: true}, (req)->
        assert.equal req.test_field, 'test'
        done()
      req =
        test_field: 'test'
        isUnauthenticated: ()->
          return true
      process.nextTick ()->
        strategy.authenticate(req)

    it 'should call success callback', (done)->
      strategy = new CreateStrategy (cb)->
        cb(null, {test: 'test'})
      req =
        isUnauthenticated: ()->
          return true
      strategy.success = (user)->
        assert.equal user.test, 'test'
        done()
      process.nextTick ()->
        strategy.authenticate(req)

    it 'should call error callback', (done)->
      strategy = new CreateStrategy (cb)->
        cb({test: 'test'})
      req =
        isUnauthenticated: ()->
          return true
      strategy.error = (err)->
        assert.equal err.test, 'test'
        done()
      process.nextTick ()->
        strategy.authenticate(req)

    it 'should call fail callback with info', (done)->
      strategy = new CreateStrategy (cb)->
        cb(null, null, {test: 'test'})
      req =
        isUnauthenticated: ()->
          return true
      strategy.fail = (info)->
        assert.equal info.test, 'test'
        done()
      process.nextTick ()->
        strategy.authenticate(req)
