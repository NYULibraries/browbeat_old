module NyuLibraries
  module Primo
    module StepHelpers
      extend self
      def bobcat
        "http://bobcatdev.library.nyu.edu/"
      end
      
      def send_share_button
        results_list_items.first.find(:xpath, ".//*[@id='share-dropdown']").find(:css, '.btn')
      end
      
      def send_share_save_option_list
        results_list_items.first.find(:xpath, ".//*[@id='share-dropdown']").find(:css, '.btn').all('ul li')
      end
      
      def send_share_option(option_name)
        results_list_items.first.find(:xpath, ".//*[@id='share-dropdown']").find(:css, '.btn').find(:xpath, ".//a[text()='#{option_name}']")
      end
      
      def modal_body
        modal.find(:css, ".modal-body")
      end
      
      def element_with_value(button_text)
        find(:xpath, "//*[@value='#{button_text}']")
      end
      
      def email_form_field_for(field, type = 'input')
        find(:xpath, "//form[@id='emailForm']").find(:xpath, ".//#{type}[@id='#{field}']")
      end
      
      def email_form_label_for(label)
        find(:xpath, "//form[@id='emailForm']//label[@for='#{label}']")
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
    end
  end
end