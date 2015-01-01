module MaitreD::Heroku
  def self.configure
    yield self
  end

  def self.listener
    @listener
  end

  def self.listener=(listener)
    @listener = listener
  end

  def self.id
    @id
  end

  def self.id=(id)
    @id = id
  end

  def self.password
    @password
  end

  def self.password=(password)
    @password = password
  end

  def self.sso_salt
    @sso_salt
  end

  def self.sso_salt=(salt)
    @sso_salt = salt
  end

  def self.provider_id_from(params)
    params['heroku_id']
  end
end

require 'maitre_d/heroku/api'
require 'maitre_d/heroku/listener'
