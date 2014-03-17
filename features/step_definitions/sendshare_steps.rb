When(/^I click on send\/share$/) do
  send_share_button.click
  send_share_button.click
end

Then(/^I should see an option for "(.*?)"$/) do |share_option_text|
  send_share_save_option_list_text = send_share_save_option_list.collect {|s| s.text}
  send_share_save_option_list_text.should include(share_option_text)
end

When(/^I click on the option for "(.*?)"$/) do |send_option_text|
  send_share_option(send_option_text).click
end

Then(/^The modal dialog should contain the email form$/) do
  modal_body.should have_content()

  email_form_field_for('subject').value.should eql("Item(s) from BobCat")
  email_form_field_for('sendTo').text.should eql("")
  email_form_label_for('saveThis').text.should eql("save this e-mail address(es) in my preferences")
  email_form_field_for('note', 'textarea').text.should eql("")
end


