require 'spec_helper'
require 'capybara/dsl'
require 'capybara/rspec'

Capybara.app = app

RSpec.configure do |config|
  config.include Capybara::DSL
end
