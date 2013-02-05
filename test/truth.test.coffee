require('chai').should()

describe 'Truth', ->
    module = require '../lib/truth'
    
    it 'should be true', ->
        module.tell().should.be.true

    it 'should not be false', ->
        module.tell().should.not.be.false
