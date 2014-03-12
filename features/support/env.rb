require 'figs'
require 'capybara/cucumber'
require 'capybara'
require 'rspec'
Figs.load()

if ENV.fetch("SAUCE","").downcase.eql? "true"
  require 'sauce/cucumber'
end

Capybara.default_driver = :selenium
Capybara.default_wait_time = 60

require_relative "helpers/helpers"
require_relative "helpers/dynamic_helpers"
World(NyuLibraries::Primo::Helpers, NyuLibraries::Core::Helpers::DynamicHelpers)
