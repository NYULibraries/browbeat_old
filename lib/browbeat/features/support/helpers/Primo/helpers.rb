module NyuLibraries
  module Primo
    module Helpers
      extend self
      def driver
        @driver ||= page.driver.browser
      end
      
      def bobcat_header_spans
        header.native.find_elements(:tag_name, "span")
      end
      
      # Navigate to the current @view and @tab
      def navigate_to_tab()
        driver.navigate.to "#{@search_url}?vid=#{@view}"
        wait = Selenium::WebDriver::Wait.new(:timeout => 20)
        wait.until {
          begin
            tabs.find_element(:css, "ul li##{@tab}")
            true
          rescue Selenium::WebDriver::Error::NoSuchElementError => e
            false
          end
        }
        tab = driver.find_element(:css, "div#tabs ul li##{@tab}")
        tab.find_element(:tag_name, "a").click unless tab[:class].eql?("selected")
        wait_for_search_field
      end
    
      # Click the eshelf link in the sidebar.
      def click_eshelf_link()
        eshelf_link.click
        wait_for_eshelf
      end
    
      # Submit a search for the given search term.
      def submit_search(search_term)
        fill_in 'search_field', :with => search_term
        click_button 'goButton'
        wait_for_search search_term
      end
    
      # Set media type
      def set_media_type(media_type_value)
        media_type = Selenium::WebDriver::Support::Select.new(driver.find_element(:id, "exlidInput_mediaType_1"))
        media_type.select_by(:value, media_type_value)
      end
    
      # Set precision operator
      def set_precision(precision_value)
        precision = Selenium::WebDriver::Support::Select.new(driver.find_element(:id, "exlidInput_precisionOperator_1"))
        precision.select_by(:value, precision_value)
      end
    
      # Set scope 1
      def set_scope1(scope1_value)
        scope1 = Selenium::WebDriver::Support::Select.new(driver.find_element(:id, "exlidInput_scope_1"))
        scope1.select_by(:value, scope1_value)
      end
    
      # Set scope 2
      def set_scope2(scope2_value)
        scope2 = Selenium::WebDriver::Support::Select.new(driver.find_element(:name, "scp.scps"))
        scope2.select_by(:value, scope2_value)
      end
    
      # Click the details link. Defaults to first link
      def click_details_link(index=0)
        title = record_title(index)
        details_link(index).click
        wait_for_details(title)
      end
    
      # Click the add to eshelf checkbox. Defaults to first record on brief screen.
      def click_add_to_eshelf(index=0)
        add_to_eshelves = driver.find_elements(:css, ".save_record input.tsetse_generated")
        add_to_eshelves[index].click
      end
      
      # Click the send/share button. Defaults to first record on brief screen.
      def click_send_share(index=0)
        send_shares = driver.find_elements :xpath, xpaths[:send_share]
        send_shares[index].click
      end
    
      # Click the email link. Defaults to first record on brief screen.
      def click_email_link(index=0)
        email_links = driver.find_elements :xpath, xpaths[:email_link]
        email_links[index].click
        wait_for_email_modal
      end
      
      # Send an email to the given email address.
      def send_email(email_address)
        subject = driver.find_element(:css, '.ui-dialog .ui-dialog-content form input#subject')
        subject.send_keys " - Jenkins probably sent this to you."
        to = driver.find_element(:css, '.ui-dialog .ui-dialog-content form input#sendTo')
        to.send_keys email_address
        to.submit
        wait_for_email_send
      end
      
      # Get the email confirmation message
      def email_confirmation()
        driver.find_element(:css, '.ui-dialog .ui-dialog-content div')
      end
      
      # Close the email modal window
      def close_email_modal()
        driver.find_element(:css, '.ui-dialog .ui-dialog-titlebar .ui-icon-closethick').click
      end
    
      # Click the print link. Defaults to first record on brief screen.
      # Switches to the print window.
      def click_print_link(index=0)
        print_links = driver.find_elements :xpath, xpaths[:print_link]
        print_links[index].click
        driver.switch_to.window(driver.window_handles.last)
      end
      
      # Close the print window
      def close_print_window()
        # Close the window
        driver.close
        # Switch back to original window.
        driver.switch_to.window(driver.window_handles.first)
      end
    
      # Return the array of sidebar boxes
      def sidebar_boxes()
        wait_for_sidebar
        sidebar.all(:css, ".navbar")
      end
    
      # Return the specified sidebar box. Default to the first box.
      def sidebar_box(index=0)
        sidebar_boxes[index]
      end
      
      # Return the specified sidebar box identified by the specified id
      def sidebar_box_by_id(id)
        wait_for_sidebar
        sidebar.find_element(:id, id)
      end
      
      # Return the account box
      def sidebar_account_box()
        sidebar_box_by_id("account")
      end
      
      # Return the help box
      def sidebar_help_box()
        sidebar_box_by_id("help")
      end
      
      # Return the additional options box
      def sidebar_additional_options_box()
        sidebar_box_by_id("additional_options")
      end
      
      # Return the array of list items for the sidebar box identified by the specified index.  Default to first box.
      def sidebar_box_items(index=0)
        sidebar_box(index).find_elements(:tag_name, "li")
      end
      
      # Return the array of list items for the sidebar box identified by the specified id
      def sidebar_box_items_by_id(id)
        sidebar_box_by_id(id).find_elements(:tag_name, "li")
      end
      
      # Return the array of account box items
      def sidebar_account_box_items()
        sidebar_box_items_by_id("account")
      end
      
      # Return the array of help box items
      def sidebar_help_box_items()
        sidebar_box_items_by_id("help")
      end
      
      # Return the array of additional options box items
      def sidebar_additional_options_box_items()
        sidebar_box_items_by_id("additional_options")
      end
      
      # Return the eshelf link
      def eshelf_link()
        eshelf_index = (@view.eql?("NYSID")) ? (driver.find_elements(:css, "a.logout").empty? ? 2 : 1 ) : 0
        sidebar_account_box_items[eshelf_index].find_element(:tag_name, "a")
      end
    
      # Return the search_form element
      def search_form()
        search_container.find("form")
      end
      
      # Return the array of facet boxes
      def facets_boxes()
        facets.all(".box")
      end
    
      # Return the specified facet box. Default to the first box.
      def facets_box(index=0)
        facets_boxes[index]
      end
      
      # Return the array of pagination elements
      def pagination_elements()
        results_list.all(".pagination")
      end
      
      # Return the results list element
      def results_list()
        page.find(:css, ".results")
      rescue
        return nil
      end
      
      def wait_for_results_list()
        wait = Selenium::WebDriver::Wait.new(:timeout => 10)
        assert_nothing_raised(Selenium::WebDriver::Error::TimeOutError, "Error waiting for search for logout #{driver.current_url} view #{@view} and tab #{@tab}.") {
          wait.until {
            begin
              results_list
              true
            rescue Selenium::WebDriver::Error::NoSuchElementError => e
              false
            end
          }
        }
      end
      
      # Return the array of results list items
      def results_list_items()
        results_list.all(".result")
      end
    
      # Return the specified results list item. Default to the first item
      def results_list_item(index=0)
        results_list_items[index]
      end
    
      # Return an array of Primo add to eshelf checkboxes
      def add_to_eshelf_checkboxes()
        driver.find_elements(:css, ".save_record input.tsetse_generated")
      end
      
      # Return the specified Primo add to eshelf checkbox. Default to the first checkbox.
      def add_to_eshelf_checkbox(index=0)
        add_to_eshelf_checkboxes[index]
      end
      
      # Return an array of Primo details link elements
      def details_links()
        results_list.all(:css, ".fulldetails a")
      end
      
      # Return the specified Primo details link. Default to the first checkbox.
      def details_link(index=0)
        details_links[index]
      end
      
      # Return the list of Primo title strings
      def record_titles()
        titles = []
        driver.find_elements(:css, ".entree h2.title").each do |title|
          titles << title.text
        end
        return titles
      end
      
      # Return the specified Primo title string. Default to the first title.
      def record_title(index=0)
        record_titles[index]
      end
    
      # Return the list of e-shelf title strings
      def eshelf_titles()
        titles = []
        driver.find_elements(:css, '.entree h2.title').each do |title|
          titles << title.text
        end
        return titles
      end
      
      # Return the specified e-shelf title string. Default to the first title.
      def eshelf_title(index=0)
        eshelf_titles[index]
      end
      
      def search_container
        page.find(:css, ".search.with-tabs")
      end
      
      def tabs
        page.find(:css, ".nav.nav-tabs")
      end
      
      def tab_list
        tabs.all("li")
      end
      
      def footer
        page.find("footer")
      end
      
      def breadcrumbs
        nav1.find(:css, ".nyu-breadcrumbs")
      end
      
      def breadcrumb_items
        breadcrumbs.all("li")
      end
      
      def wait_for_sidebar()
        wait = Selenium::WebDriver::Wait.new(:timeout => 10)
        wait.until {
          begin
            sidebar
            true
          rescue Selenium::WebDriver::Error::NoSuchElementError => e
            false
          end
        }
      end
    
      # Wait for the search field to display
      def wait_for_search_field()
        wait = Selenium::WebDriver::Wait.new(:timeout => 10)
        wait.until {
          begin
            search_field
            true
          rescue Selenium::WebDriver::Error::NoSuchElementError => e
            false
          end
        }
      end
    
      # Wait for the search for the 'search_term' to complete
      def wait_for_search(search_term)
        wait = Selenium::WebDriver::Wait.new(:timeout => 10)
        wait.until {
          begin
            search_field
            driver.title.eql?("BobCat - #{search_term}")
          rescue Selenium::WebDriver::Error::NoSuchElementError => e
            false
          end
        }
      end
      
      # Wait for the full details page for the given 'title' to render
      def wait_for_details(title)
        wait = Selenium::WebDriver::Wait.new(:timeout => 10)
        wait.until { driver.title.eql?("BobCat - #{title}") }
      end
      
      # Wait for the email modal to display.  Generally Primo::Helpers#click_email_link should be used instead
      def wait_for_email_modal()
        wait = Selenium::WebDriver::Wait.new(:timeout => 10)
        assert_nothing_raised(Selenium::WebDriver::Error::TimeOutError, "Error waiting for email modal for url #{driver.current_url} view #{@view} and tab #{@tab}.") {
          wait.until {
            begin
              driver.find_element(:css, ".ui-dialog .ui-dialog-content form#mailFormId")
              true
            rescue Selenium::WebDriver::Error::NoSuchElementError => e
              false
            end
          }
        }
      end
      
      # Wait for the email to send.  Generally Primo::Helpers#send_email should be used instead
      def wait_for_email_send()
        wait = Selenium::WebDriver::Wait.new(:timeout => 10)
        assert_nothing_raised(Selenium::WebDriver::Error::TimeOutError, "Error waiting for email to send for url #{driver.current_url} view #{@view} and tab #{@tab}.") {
          wait.until {
            begin
              email_confirmation
              true
            rescue Selenium::WebDriver::Error::NoSuchElementError => e
              false
            end
          }
        }
      end
      
      # Wait to add to the eshelf.  Generally Primo::Helpers#add_to_eshelf should be used instead
      def wait_for_add_to_eshelf(index=0)
        wait = Selenium::WebDriver::Wait.new(:timeout => 10)
        assert_nothing_raised(Selenium::WebDriver::Error::TimeOutError, "Error waiting to add to eshelf for url #{driver.current_url} view #{@view} and tab #{@tab}.") {
          wait.until {
            wait = Selenium::WebDriver::Wait.new(:timeout => 10)
            wait.until { 
              (not driver.find_elements(:css => ".save_record label.tsetse_generated")[index].text.match("^In").nil?)
            }
          }
        }
      end
      
      # Wait to add to the eshelf.  Generally Primo::Helpers#add_to_eshelf should be used instead
      def wait_for_uncheck_add_to_eshelf(index=0)
        wait = Selenium::WebDriver::Wait.new(:timeout => 10)
        assert_nothing_raised(Selenium::WebDriver::Error::TimeOutError, "Error waiting to add to eshelf for url #{driver.current_url} view #{@view} and tab #{@tab}.") {
          wait.until {
            wait = Selenium::WebDriver::Wait.new(:timeout => 10)
            wait.until { 
              (not driver.find_elements(:css => ".save_record label.tsetse_generated")[index].text.match("^Add").nil?)
            }
          }
        }
      end
      
      # Wait for the eshelf to render.  Generally Primo::Helpers#click_eshelf_link should be used instead
      def wait_for_eshelf()
        wait = Selenium::WebDriver::Wait.new(:timeout => 10)
        assert_nothing_raised(Selenium::WebDriver::Error::TimeOutError, "Error waiting for eshelf for url #{driver.current_url} view #{@view} and tab #{@tab}.") {
          wait.until {
            driver.find_element(:css, "h1").text == "e-Shelf"
          }
        }
      end
      
      # Wait for pds to render.  Generally Primo::Helpers#login should be used instead
      def wait_for_pds()
        wait = Selenium::WebDriver::Wait.new(:timeout => 10)
        assert_nothing_raised(Selenium::WebDriver::Error::TimeOutError, "Error waiting for pds for url #{driver.current_url} view #{@view} and tab #{@tab}.") {
          wait.until {
            driver.title.eql?("BobCat")
          }
        }
      end
      
      # Wait for shibboleth to render.
      def wait_for_shibboleth_button()
        wait = Selenium::WebDriver::Wait.new(:timeout => 10)
        assert_nothing_raised(Selenium::WebDriver::Error::TimeOutError, "Error waiting for pds for url #{driver.current_url} view #{@view} and tab #{@tab}.") {
          wait.until {
            begin
              shibboleth_button
              true
            rescue Selenium::WebDriver::Error::NoSuchElementError => e
              false
            end
          }
        }
      end
      
      # Wait for shibboleth form to render. 
      def wait_for_shibboleth_form()
        wait = Selenium::WebDriver::Wait.new(:timeout => 10)
        assert_nothing_raised(Selenium::WebDriver::Error::TimeOutError, "Error waiting for pds for url #{driver.current_url} view #{@view} and tab #{@tab}.") {
          wait.until {
            begin
              shibboleth_form
              true
            rescue Selenium::WebDriver::Error::NoSuchElementError => e
              false
            end
          }
        }
      end
      
      # Wait for login to process.  Generally Primo::Helpers#login should be used instead
      def wait_for_login()
        wait = Selenium::WebDriver::Wait.new(:timeout => 10)
        assert_nothing_raised(Selenium::WebDriver::Error::TimeOutError, "Error waiting for login for url #{driver.current_url} view #{@view} and tab #{@tab}.") {
          wait.until {
            begin
              logout_element
              true
            rescue Selenium::WebDriver::Error::NoSuchElementError => e
              false
            end
          }
        }
      end
      
      # Wait for logout to process.  Generally Primo::Helpers#logout should be used instead
      def wait_for_logout()
        wait = Selenium::WebDriver::Wait.new(:timeout => 10)
        assert_nothing_raised(Selenium::WebDriver::Error::TimeOutError, "Error waiting for search for logout #{driver.current_url} view #{@view} and tab #{@tab}.") {
          wait.until {
            begin
              driver.find_element(:css, ".logout > h1")
              true
            rescue Selenium::WebDriver::Error::NoSuchElementError => e
              false
            end
          }
        }
      end
    
      private
      def sort_by(sort_value)
        sort_select = Selenium::WebDriver::Support::Select.new(driver.find_element(:id, "srt"))
        sort_select.select_by(:value, sort_value)
      end
    end
  end
end