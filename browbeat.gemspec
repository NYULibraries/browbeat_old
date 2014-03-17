# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = 'browbeat'
  s.version     = "2.0.0"
  s.platform    = Gem::Platform::RUBY
  s.date        = '2014-03-17'
  s.summary     = "Tool to test common elements."
  s.description = "Leverages capybara cucumber and saucelabs."
  s.authors     = ["hab278"]
  s.email       = 'hab278@nyu.edu'
  s.homepage    = "https://github.com/NYULibraries/browbeat"
  
  s.files       = Dir["{lib,config}/**/*"] + ["Figsfile", "Gemfile", "README.md"]
  
  s.add_dependency "sauce-cucumber"
  s.add_dependency "sauce-connect"
  s.add_dependency "figs"
  s.add_dependency "capybara"
  s.add_development_dependency "debugger"
  s.add_dependency "rspec"
end
