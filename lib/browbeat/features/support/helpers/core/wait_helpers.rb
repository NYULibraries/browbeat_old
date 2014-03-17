module NyuLibraries
  module Core
    module Helpers
      module WaitHelpers
        extend self
        BROWBEAT_WAIT_TIME = 20
        
        # The common wait for element. If the element is found, it resolves true. A custom message can be set.
        def wait_for(element, msg = "Error waiting for element #{element}")
          wait = Selenium::WebDriver::Wait.new(:timeout => BROWBEAT_WAIT_TIME)
          wait.until {
            begin
              send(element)
              true
            rescue Selenium::WebDriver::Error::NoSuchElementError, NoMethodError => e
              puts msg
              false
            end
          }
        end
        
        # Unlike wait_for, this element waits for an element given the class of that element.
        def wait_for_element_by_class(element_class, msg = "Error waiting for element with class #{element_class}")
          wait = Selenium::WebDriver::Wait.new(:timeout => BROWBEAT_WAIT_TIME)
          wait.until {
            begin
              @driver.find_element(:class, element_class)
              true
            rescue Selenium::WebDriver::Error::NoSuchElementError => e
              puts msg
              false
            end
          }
        end
        
        # Wait for page title to show.
        def wait_for_page_title()
          wait_for :page_title, "Error waiting for page title to load"
        end
        
        # Wait for logout to process.  
        def wait_for_logout_page()
          wait_for :logout_page, "Error waiting for search for logout"
        end
        
        # Wait for shibboleth form to render. 
        def wait_for_shibboleth_form()
          wait_for :shibboleth_form, "Error waiting for pds"
        end
        
        # Wait for shibboleth button to appear.
        def wait_for_shibboleth_button_element()
          wait_for_element_by_class :btn, "Error waiting for shibboleth button"
        end
        
        # Wait for logout element to appear.
        def wait_for_logout_element()
          wait_for :logout_element, "No logout element/not logged in"
        end
        
        # Wait for logout element to appear.
        def wait_for_login_element()
          wait_for :login_element, "Error waiting for login element, you are possibly logged in "
        end
      end
    end
  end
end