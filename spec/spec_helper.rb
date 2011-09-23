require 'rubygems'
require 'bundler'
Bundler.require

Goliath.env = :test

require File.expand_path(File.join(File.dirname(__FILE__),'..','gorilla'))

Bundler.setup(:default, :test)
require 'goliath/test_helper'
