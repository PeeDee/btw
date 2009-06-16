#!/usr/bin/ruby
## btw = bare text wiki

require 'rubygems'
require 'camping'     # ruby for fcgi: http://camping.rubyforge.org/

#in dispatch: export PUB_ROOT='/Users/Shared/Movies'
#BTW_LOCAL # if defined then running on local machine

#Pseudocode
# anything following hostname is taken to be a path from PUB_ROOT
#   if a directory, display a file list
#     linking to respective path from PUB_ROOT
#     directories first
#     filtering out junk files
#   if a file
#     if a browser type, send hostname+path link to browser
#     if a type we format, send to_html content to browser within layout
#       if BTW_LOCAL defined, send system call to open PUB_ROOT + path

Camping.goes :Btw # name of application, has to be initial caps

  # module Btw::Models # no internal data model at all

module Btw::Controllers

  class Route < R '/', '/(\S+)'
    def get(rel_path = "")
      @rel_path = rel_path
      @full_path = ENV['PUB_ROOT'] + "/" + @rel_path
      puts "List for: #{@full_path}"
      @file_list = Dir.entries(@full_path)
      puts "files: #{@file_list}"
      render :directory_listing
    end
  end
    
end # Controllers

module Btw::Views
  def layout
    puts "Layout with: #{@rel_path}"
    html do
      body do
        h1 "Directory Listing: #{@full_path}"
        self << yield
      end
    end
  end

  def directory_listing
    ul do
      @file_list.each { |f| li f }
    end
  end

end

