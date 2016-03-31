require 'capybara/cucumber'
require 'capybara'
require 'rspec'

if ENV.fetch("SAUCE","").downcase.eql? "true"
  require 'sauce/cucumber'
  require 'figs'
  Figs.load()
end

Capybara.default_driver = :selenium
Capybara.default_max_wait_time = 10

require_relative "helpers/core/dynamic_helpers"
require_relative "helpers/core/login_helpers"
require_relative "helpers/core/wait_helpers"
require_relative "helpers/Primo/helpers"
require_relative "helpers/Primo/step_helpers"
World(NyuLibraries::Primo::Helpers, NyuLibraries::Primo::StepHelpers, NyuLibraries::Core::Helpers::DynamicHelpers,
      NyuLibraries::Core::Helpers::LoginHelpers, NyuLibraries::Core::Helpers::WaitHelpers)
