Rails.application.routes.draw do
  mount MaitreD::Heroku::API    => '/heroku'
  mount MaitreD::Opperator::API => '/opperator'
end
