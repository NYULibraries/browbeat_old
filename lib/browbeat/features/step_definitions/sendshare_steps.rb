When(/^I click on send\/share$/) do
  send_share_button.click
  send_share_button.click
end

Then(/^I should see an option for "(.*?)"$/) do |share_option_text|
  send_share_save_option_list_text = send_share_save_option_list.collect {|s| s.text}
  send_share_save_option_list_text.should include(share_option_text)
end