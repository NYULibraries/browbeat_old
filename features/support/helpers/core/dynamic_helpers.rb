module NyuLibraries
  module Core
    module Helpers
      module DynamicHelpers
        # Returns true if the method can be evaluated to a method name
        # and parameter.
        def respond_to?(method, include_private=false)
          if(matches?(method))
            return true
          else
            super
          end
        end
        
        private
        
        # Driver access for using capybara.
        def driver
          @driver ||= page.driver.browser
        end
        
        # Checks to see if the method matches any known method pattern.
        def matches?(method)
          navigate_method?(method) || element_id_method?(method)  || wait_method?(method) || element_id_exists_method?(method)
        end
        
        # Navigate methods use the navigate_to method and try to see if theres an instance variable available to navigate to.
        def navigate_method?(method)
          (method.to_s.start_with?("navigate_to_") && !instance_variable_get("@#{method.to_s.sub('navigate_to_','')}").nil?)
        end
        
        # Element id methods see if there is an element with the given id on the current page.
        def element_id_method?(method)
          driver.find_element(:id, method.to_s)
        rescue
          false
        end
        
        # Wait methods wait for certain elements to appear.
        def wait_method?(method)
          method.to_s.start_with?("wait_for_")
        end
        
        # Element id exists methods check to see if the method even exists.
        def element_id_exists_method?(method)
          method.to_s[-1].eql?('?')
        end
        
        # Method missing dynamically creates methods based on certain criteria. Currently, navigate methods, element id methods, wait
        # methods, and element id exists methods can be created.
        def method_missing(method, *args, &block)
          # Check to see if it can be evaluated
          if(matches?(method))
            #Defines the method and caches it to the class
            self.class.send(:define_method, method) do
              if element_id_exists_method?(method)
                if respond_to?(method.to_s.chop)
                  begin
                    send method.to_s.chop
                  rescue Selenium::WebDriver::Error::NoSuchElementError => e
                    return false
                  end
                  return true
                end
              elsif wait_method?(method)
                send :wait_for, method.to_s.sub('wait_for_','').to_sym
              elsif navigate_method?(method)
                send :navigate_to, instance_variable_get("@#{method.to_s.sub('navigate_to_','')}")
              elsif element_id_method?(method)
                find(:xpath, "//*[@id='#{method.to_s}']")
              end
            end
            # calls the method
            send(method, *args, &block)
          else
            super
          end
        end
      end
    end
  end
end