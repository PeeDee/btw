#!/usr/bin/ruby
## btw = bare text wiki

require 'rubygems'
require 'camping'     # ruby for fcgi: http://camping.rubyforge.org/files/README.html

#remote dispatch.cgi, local .profile: export WIKI_ROOT='/Users/----/Documents/Wiki'
#BTW_LOCAL # ?? if defined then running on local machine ??

#Pseudocode
# anything following hostname is taken to be a path from PUB_ROOT
#   if a directory, display a file list
#     linking to respective path from PUB_ROOT
#     directories first
#     filtering out junk files
#   if a file
#     if a browser type, send hostname+path link to browser
#     if a type we format, send to_html content to browser within layout
#       if BTW_LOCAL defined, send system call to open WIKI_ROOT + path

Camping.goes :Btw # name of application, has to be initial caps

# module Btw::Models # no internal data model at all
module Btw::Controllers

  #  class Index < R ''
  #    def get; end
  #  end
  #
  class DisplayPath < R '/(.*)' # capture any character
    # \S* is any except white space: [^\s\t\r\n\f]

    def get(rel_path = "/")
      puts "DisplayPath.get called with #{rel_path}"
      #rel_path = "/" if rel_path == "favicon.ico" #??? No idea.
      unless rel_path == "favicon.ico" then
        @url_path = (URL('/').to_s).chop! # cannot be in get()
        @rel_path = good_path(rel_path)
        @full_path = good_path(ENV['WIKI_ROOT'] + @rel_path)
        # if a directory...
        render :directory_listing 
      end
      
    end
    
  end

end # Controllers

module Btw::Views
  def layout
    html do
      body do
        self << yield
      end
    end
  end

  def directory_listing
    pre show_paths
    h1 "Directory Listing: #{@full_path}" ; puts "Directory Listing: #{@full_path}"
    @file_list = Dir.entries(@full_path) #; puts "directory_listing: #{@file_list}..."
    @file_list.delete_if {|f| f[0] == 46 } # remove files beginning with '.'
    ul do
      pre show_paths
      li { breadcrumbs(@url_path, @rel_path) } #FIXME somehow altering @url_path...
      pre show_paths
      @file_list.each { |f| li {a f, :href=> "#{@url_path}#{@rel_path}#{good_path(f)}"} }
    end
  end

  def show_paths
    "
      Wiki Root: #{ENV['WIKI_ROOT']}
      Relative path: #{@rel_path}
      Full path: #{@full_path}
      URL path: #{@url_path}
    "
  end

end

module Btw::Helpers

  # ensures that paths begin with slash but don't end with one
  # special case is root path /
  def good_path(raw_path)
    return '' if raw_path == '/'
    raw_path = '/' + raw_path unless raw_path[0] == 47 # add beginning slash
    raw_path.chop! if raw_path[-1] == 47 # remove trailing slash
    return raw_path
  end

  def breadcrumbs(base_path, tree)
    path = base_path
    crumbs = tree.split('/'); crumbs.shift
    links =  a "home", :href => "#{path}"
    crumbs.each { |dir|
      path << good_path(dir)
      links << " << "
      links << a( dir, :href => "#{path}")
    }
    return links
  end


end


##postamble from http://camping.rubyforge.org/classes/Camping/FastCGI.html
#if __FILE__ == $0
##  require 'camping/fastcgi'
##  Camping::FastCGI.start(Btw)
#end

## For CGI
#if $0 == __FILE__
#  Btw.create
#  Btw.run
#end
