Then(/^I should see a modal dialog/) do
  modal.should be_visible
end

Then(/^I should see the message "(.*?)"$/) do |message|
  expect(find(:css, ".alert.alert-success").text).to eql(message)
end