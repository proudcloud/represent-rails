Given /^I have a user account$/ do
  create_user
end

Given /^I do not have a user account$/ do
  create_visitor
  delete_user
end

Given /^I am not signed in$/ do
  page.driver.submit :delete, destroy_user_session_path, {}
end

Given /^I am signed in$/ do
  create_visitor
  sign_in
end

When /^I sign out$/ do
  page.driver.submit :delete, destroy_user_session_path, {}
  #click_link "LOG-OUT"
end

When /^I return to the site$/ do
  visit root_path
end

When /^I sign in with valid credentials$/ do
  create_visitor
  sign_in
end

When /^I sign in with invalid credentials$/ do
  create_visitor
  @visitor = @visitor.merge email: "wrong"
  sign_in
end

Then /^I should be signed in$/ do
  page.should have_content "Logout"
end

Then /^I should be signed out$/ do
  visit admin_path
  page.should have_xpath "//input[@value='Sign in']"
end

