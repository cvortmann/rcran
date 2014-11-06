require 'rubygems'
require 'sinatra'
require 'mongoid'
require './entities/version'
require 'slim'

configure do
  Mongoid.load!("config/mongoid.yml")
end

get '/' do
  @all = Version.all.group_by(&:name)
  slim :index
end
