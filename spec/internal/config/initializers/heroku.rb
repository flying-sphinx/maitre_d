require 'maitre_d/heroku'

MaitreD::Heroku.configure do |config|
  config.id       = 'foo'
  config.password = 'bar'
  config.sso_salt = 'sea salt'
  config.listener = HerokuListener
end
