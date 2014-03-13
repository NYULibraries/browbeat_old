module NyuLibraries
  module Primo
    module StepHelpers
      extend self
      
      def bobcat
        "http://bobcat.library.nyu.edu/"
      end
      
      def have_results
        have_xpath("//div[@id='results']")
      end
      
      def have_results_header
        have_xpath("//div[@id='results']/div[@id='results_header']")
      end
      
      def have_results_list
        have_xpath("//*[@id='resultsList']")
      end
      
      def have_facets
        have_xpath("//*[@id='facets']")
      end
      
      def have_header
        have_xpath("//*[@id='header']")
      end
      
      def have_facet_header
        have_selector('h3')
      end
      
      def have_facet_list
        have_css('.facet_list')
      end
    end
  end
end