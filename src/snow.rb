require 'bundler/setup'

require 'sinatra/base'
require 'sinatra/reloader'

require 'json'
require 'mongo'

load 'snowball.rb'
load 'base.rb'
load 'operations.rb'