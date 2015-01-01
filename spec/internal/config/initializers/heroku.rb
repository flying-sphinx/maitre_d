require 'maitre_d/heroku'

MaitreD::Heroku.configure do |config|
  config.id       = 'foo'
  config.password = '056e8ff3d55ea6e1a7cc4aa7afeaf3ac'
  config.sso_salt = 'db0ce73d4bd2dfa1d66c713a9aaf8f76'
  config.listener = HerokuListener
end
