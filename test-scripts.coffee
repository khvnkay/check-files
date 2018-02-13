{  TimeStamp } = require './index'
{ expect } = require 'chai'
_ = require 'lodash'
path = require 'path'
Promise = require 'bluebird'

describe "get Time stamp", ->
  it "should get TimeStamp of file",->
    TimeStamp()
