Given(/^I am on the Bobcat homepage$/) do
  visit "https://bobcat.library.nyu.edu/"
end

When(/^I search for "(.*?)"$/) do |arg1|
  fill_in 'search_field', :with => arg1
  click_button 'goButton'
end

Then(/^I should see result number "(.*?)" should be "(.*?)"$/) do |element_number, expected_title|
  result_title = find(:xpath, "//*[@id='resultsList']/li[#{element_number}]/div[3]/h2/a").text
  expect(result_title).to eq(expected_title)
end

Then(/^I should see that the title of default search page is "(.*?)"$/) do |expected_title|
  expect(page.title).to eq(expected_title)
end

Then(/^I should see common elements$/) do
  page.should have_xpath("//*[@id='header']")
  bobcat_header_spans = page.driver.browser.find_element(:id, "header").find_elements(:tag_name, "span")
  expect(bobcat_header_spans.size).to eq(2)
  bobcat_header_spans.each do |span|
    expect(span.text).to eq("")
  end
end

Then(/^I should see facets$/) do
  page.should have_xpath("//*[@id='facets']")
  facets = find(:xpath, "//*[@id='facets']")
  facets.tag_name.should eq("div")
  facets.has_content?.should be(true)
  facets.all(".box").each do |box|
    box.should have_selector('h3')
    box.should have_css('.facet_list')
  end
end

Then(/^I should see results$/) do
  page.should have_xpath("//div[@id='results']")
  page.should have_xpath("//div[@id='results']/div[@id='results_header']")
  page.should have_xpath("//*[@id='resultsList']")
  results_list = page.find(:xpath, "//*[@id='resultsList']")
  results_list.tag_name.should eq("ul")
  results_list.all(".result").empty?.should be(false)
  results_list.all(".result").size.should have_at_most(10).items
  results_list.all(".result").each do |result|
    result.tag_name.should eq("li")
  end
end

Then(/^I should see pagination$/) do
  results = find(:xpath, "//div[@id='results']")
  pagination_elements = results.all(".pagination")
  pagination_elements.empty?.should be(false)
  pagination_elements.should have_exactly(2).items
  pagination_elements.each do |pagination_element|
    pagination_element.tag_name.should eq("div")
  end
end