Then(/^I should see the RSS icon next to tip of the week$/) do
  rss_image_style.should eq("url(\"https://library.nyu.edu/images/famfamfam/feed.png\")")
end