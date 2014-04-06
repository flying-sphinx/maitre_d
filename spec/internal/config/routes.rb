Rails.application.routes.draw do
  mount MaitreD::Broadstack::API   => '/broadstack'
  mount MaitreD::Heroku::API       => '/heroku'
  mount MaitreD::CloudControl::API => '/cloudcontrol'
  mount MaitreD::Opperator::API    => '/opperator'

  class Dashboard
    def self.call(env)
      [200, {'Content-Type' => 'text/plain', 'Content-Length' => '9'},
        ['Dashboard']]
    end
  end
  match '/my/dashboard' => Dashboard
end
