require 'bundler/setup'

require 'combustion'
require 'maitre_d'

Combustion.initialize! :action_controller

require 'rspec/rails'

RSpec.configure do |config|
  config.include RSpec::Rails::RequestExampleGroup, :type => :request
end
