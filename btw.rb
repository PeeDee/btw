#!/usr/bin/ruby
## btw = bare text wiki

require 'camping'     # ruby for fcgi: http://camping.rubyforge.org/

#PUB_ROOT ||= "" # root node of wiki file tree, define in dispatch.fcgi

Camping.goes :Btw # name of application, has to be initial caps

  # module Btw::Models # no internal data model at all

  module Btw::Controllers
    class Index < R '/'
      def get
        @file_list = ["one", "two"] # get valid file list from PUB_ROOT
        render :index
      end
    end
  end

  module Btw::Views
    def layout
      html do
        body do
          h1 "btw file list"
          self << yield
        end
      end
    end

    def index
      for file in @file_list
        p "link to file #{file}"
      end
  end

end
  
