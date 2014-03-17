Then(/^I should see the RSS icon next to tip of the week$/) do
  page.should have_rss_image
end