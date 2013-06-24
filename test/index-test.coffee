assert = require 'assert'
create = require '../'


describe 'passport-create', ()->
  
  describe 'module', ()->
    it 'should report a version', ()->
      #from underscore
      assert.equal Object.prototype.toString.call(create.version), '[object String]'