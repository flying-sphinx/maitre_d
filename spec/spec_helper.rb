require 'bundler/setup'

require 'combustion'
require 'maitre_d'

Combustion.initialize! :action_controller

require 'rspec/rails'

RSpec.configure do |config|
  config.include RSpec::Rails::RequestExampleGroup, :type => :request,
    :example_group => {:file_path => /spec\/api/}
end
