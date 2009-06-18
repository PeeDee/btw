#!/usr/bin/ruby
# my_app.rb

  require 'rubygems'
  require 'sinatra/base'

class MyApp < Sinatra::Base

get '/' do
  "Hello world, it's #{Time.now} at the server!"
end

get '/hello/:name' do
    # matches "GET /hello/foo" and "GET /hello/bar"
    # params[:name] is 'foo' or 'bar'
    "Hello #{params[:name]}!"
end
  
end

if $0 == __FILE__
  MyApp.run!
end
