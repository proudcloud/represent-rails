Given /^I am on the (.+) page$/ do |page|
  if page == "home"
    page = "root"
  end

  eval "visit #{page}_path"
end

When /^I click on the link "(.*?)"$/ do |link|
  click_link link
end

When /^I click on the button "(.*?)"$/ do |button|
  click_button button
end

Then /^I should see "(.*?)"$/ do |content|
  page.should have_content content
end

Then /^I should be redirected to the (.+) page$/ do |page|
  if page == "home"
    page = "root"
  end

  eval "current_path.should eq #{page}_path"
end

