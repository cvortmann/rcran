require 'rubygems'
require 'sinatra'
require 'mongoid'
require './entities/version'

configure do
  Mongoid.load!("config/mongoid.yml")
end

before do
  content_type :json
end

get '/' do
  Version.all.to_json(except: [:_id])
end
