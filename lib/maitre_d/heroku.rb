module MaitreD::Heroku
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
end

require 'maitre_d/heroku/api_helpers'
require 'maitre_d/heroku/api'
