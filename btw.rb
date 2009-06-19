#!/usr/bin/ruby
## btw.rb - bare text wiki
#
# use rerun with: [btw]> rerun 'ruby btw.rb'

require 'rubygems'
require 'sinatra/base'   # http://github.com/sinatra/sinatra/tree/master
require 'haml'           # http://github.com/nex3/haml/tree/master
#require 'erb'


class Btw < Sinatra::Base
  use_in_file_templates!  # seems to be required to see the templates at end

  get '/favicon.ico' do ; end # flushes spurious browser requests

  get '/*' do
    puts "get was called with '#{params["splat"]}'"
    @rel_path = params["splat"].to_s
    @full_path = ENV['WIKI_ROOT'] + '/' + @rel_path
    # if a directory...
    @file_list = Dir.entries(@full_path) #; puts "directory_listing: #{@file_list}..."
    @file_list.delete_if {|f| f[0] == 46 } # remove files beginning with '.'
    haml :directory_listing
  end

  helpers do

    # defines links to parent directory tree
    def breadcrumbs(tree)
      path = ""
      links =  %Q{<a href="/">home</a>}
      tree.split('/').each { |dir|
        path << ('/' + dir)
        links << " << "
        links << %Q{<a href="#{path}">#{dir}</a>}
      }
      return links
    end

  end
      
end

if $0 == __FILE__
  Btw.run! :host => 'localhost', :port => 9090
end

## In-file Templates

__END__


@@ layout
!!! XML
!!!
%html
  %head
    %title Bare Text Wiki
  %body
    %ul#debug_headers
      %li= "Wiki Root: #{ENV['WIKI_ROOT']}"
      %li= "Relative path: #{@rel_path}"
      %li= "Full path: #{@full_path}"
    #container= yield

@@ directory_listing
%h1 Bare Text Wiki - Directory Listing
%p= breadcrumbs(@rel_path)
%ul#list
  - @file_list.each do |f|
    %li= %Q{<a href="#{@rel_path}/#{f}">#{f}</a>}
      

