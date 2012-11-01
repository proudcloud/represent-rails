Then /^I should see the Place Submission form$/ do
  page.should have_css "#modal_add"
end

When /^I fill out the Place Submission form$/ do
  fill_in "place_owner_name", with: "Sample User"
  fill_in "place_owner_email", with: "sample@user.com"
  fill_in "place_title", with: "Sample Event"
  fill_in "place_address", with: "123 Sesame Street"
  fill_in "place_uri", with: "http://www.example.com"
  fill_in "place_description", with: "Sample Description"
end

When /^I submit the form$/ do
  click_button "Save"
end

Then /^my application should be submitted for approval$/ do
  page.should have_content "Thanks, your entry has been submitted and will be reviewed shortly!"
end
