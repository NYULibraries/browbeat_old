Given(/^I am on the Bobcat homepage$/) do
  visit bobcat
end

Given(/^I am on the Bobcat homepage with "(.*?)" view$/) do |view|
  @view = view
  visit bobcat(view)
end

When(/^I search for "(.*?)"$/) do |search_term|
  expect{submit_search(search_term)}.to_not raise_error
end

Then(/^I should see result number "(.*?)" should be "(.*?)"$/) do |element_number, expected_title|
  expect(result_title).to eq(expected_title)
end

Then(/^I should see that the title of default search page is "(.*?)"$/) do |expected_title|
  expect(page.title).to eq(expected_title)
end

Then(/^I should see common elements$/) do
  page.should have_header
  bobcat_header_spans.should have_exactly(3).spans
  bobcat_header_spans.each do |span|
    if ["nyhistory", "brooklynhistory"].include? @view
      expect(span.text).to eq("NYU Libraries")
    else
      expect(span.text).to eq("")
    end
  end
end

Then(/^I should see facets$/) do
  page.should have_facets
  facets.tag_name.should eq("div")
  facets.should have_content
  facets_boxes.each do |box|
    box.should have_facet_header
    box.should have_facet_list
  end
end

Then(/^I should see results$/) do
  page.should have_results
  page.should have_results_count
  page.should have_results_list
  results_list.tag_name.should eq("div")
end

Then(/^I should see (\d+) result items$/) do |number_of_results|
  results_list_items.should have_exactly(number_of_results).items
  results_list_items.each do |result|
    result.tag_name.should eq("div")
  end
end

Then(/^I should see pagination$/) do
  pagination_elements.should_not be_empty
  pagination_elements.should have_exactly(2).items
  pagination_elements.each do |pagination_element|
    pagination_element.tag_name.should eq("div")
  end
end
