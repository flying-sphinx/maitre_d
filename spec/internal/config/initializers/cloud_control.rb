require 'maitre_d/cloud_control'

MaitreD::CloudControl.configure do |config|
  config.id       = 'baz'
  config.password = 'qux'
  config.sso_salt = 'rock salt'
  config.listener = CloudControlListener
end
