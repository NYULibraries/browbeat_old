module NyuLibraries
  module Primo
    module StepHelpers
      extend self
      def bobcat(view="")
        "http://bobcatdev.library.nyu.edu/#{view}"
      end
      
      def have_rss_image
        have_css(".icons-famfamfam-rss")
      end
      
      def rss_image_style
        rss_link.native.css_value('backgroundImage')
      end
      
      def send_share_button
        results_list_items.first.find(:xpath, ".//*[@id='share-dropdown']").find(:css, '.btn')
      end
      
      def send_share_save_option_list
        results_list_items.first.find(:xpath, ".//*[@id='share-dropdown']").find(:css, '.btn').all(:css, ".save_option")
      end
      
      def have_results
        have_css(".results")
      end
      
      def have_results_count
        have_xpath("//p[@id='count']")
      end
      
      def have_results_list
        have_css(".result")
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
      
      def should_have_breadcrumbs
        nav1.tag_name.should eq("nav")
        breadcrumbs.tag_name.should eq("ul")
        breadcrumb_items.should have_at_least(1).item
        breadcrumb_items.should have_at_most(4).items
      end
      
      def should_have_sidebar
        sidebar.tag_name.should eq("div")
        sidebar_boxes.should have_at_least(1).box
        sidebar_boxes.should have_at_most(4).boxes
      end
      
      def should_have_search_form
        search_container.tag_name.should eq("div")
        search_form.tag_name.should eq("form")
      end
      
      def should_have_tabs
        tabs.tag_name.should eq("ul")
        tab_list.should have_at_least(1).tab
      end
      
      def should_have_footer
        footer.tag_name.should eq("footer")
      end
    end
  end
end