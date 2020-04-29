require 'capybara'
require 'capybara/cucumber'
require 'mongoid'
require '././api_app.rb'

Mongoid.load! 'mongoid.config', :test


begin
  require 'database_cleaner'
  require 'database_cleaner/cucumber'
  DatabaseCleaner.strategy = :truncation
rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end

before do
  DatabaseCleaner.start
end

after do |scenario|
  DatabaseCleaner.clean
end

Capybara.app = ApiApp
