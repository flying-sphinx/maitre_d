require 'maitre_d/broadstack'

MaitreD::Broadstack.configure do |config|
  config.id       = 'foo'
  config.password = 'bar'
  config.sso_salt = 'sea salt'
  config.listener = BroadstackListener
end
