#!/usr/bin/ruby
# my_app_test.rb

require 'my_app.rb'
require 'test/unit'
require 'rack/test'

  class MyAppTest < Test::Unit::TestCase
    include Rack::Test::Methods

    def app
      MyApp
    end

    def test_it_says_hello_world
      get '/'
      assert last_response.ok?
      last_response.body.include?('Hello world!')
    end

    def test_it_says_hello_to_a_person
      get '/hello/Simon'
      assert last_response.ok?
      assert last_response.body.include?('Simon')
    end

#     def test_with_rack_env
#       get '/', {}, 'HTTP_USER_AGENT' => 'Songbird'
#       assert_equal "You're using Songbird!", last_response.body
#     end
  end
 