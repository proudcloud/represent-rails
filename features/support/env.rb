require 'rubygems'
require 'spork'
 
Spork.prefork do
  # Prevent Devise from loading models
  #Spork.trap_method(Rails::Application::RoutesReloader, :reload!)

  ENV["RAILS_ENV"] = 'test'
  require 'cucumber/rails'
  require 'cucumber/rspec/doubles'

  # Capybara defaults to XPath selectors rather than Webrat's default of CSS3. In
  # order to ease the transition to Capybara we set the default here. If you'd
  # prefer to use XPath just remove this line and adjust any selectors in your
  # steps to use the XPath syntax.
  Capybara.default_selector = :css

  Rails.logger.level = 4
end

Spork.each_run do
  require 'factory_girl_rails'
  # Force FactoryGirl changes to take effect immediately
  FactoryGirl.reload

  # ActionController::Base.allow_rescue = false

  begin
    require 'database_cleaner'
    require 'database_cleaner/cucumber'
    DatabaseCleaner.strategy = :truncation
  rescue NameError
    raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
  end  

  # Possible values are :truncation and :transaction
  # The :transaction strategy is faster, but might give you threading problems.
  # See https://github.com/cucumber/cucumber-rails/blob/master/features/choose_javascript_database_strategy.feature
  Cucumber::Rails::Database.javascript_strategy = :truncation

end
