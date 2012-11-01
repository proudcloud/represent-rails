When /^I change the site name/ do
  fill_in "setting_site_name", with: "rawr"
end

Then /^my changes should be saved$/ do
  page.should have_content "rawr"
end
