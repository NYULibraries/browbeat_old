require 'figs'
require 'capybara/cucumber'
require 'sauce/cucumber'
require 'capybara'
require 'rspec'
Figs.load()
Capybara.default_driver = :selenium
Capybara.default_wait_time = 60


require_relative "helpers/helpers"
World(Helpers)
