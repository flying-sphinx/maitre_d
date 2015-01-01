Rails.application.routes.draw do
  mount MaitreD::API.new                        => '/heroku'
  mount MaitreD::API.new(MaitreD::CloudControl) => '/cloudcontrol'

  class Dashboard
    def self.call(env)
      [200, {'Content-Type' => 'text/plain', 'Content-Length' => '9'},
        ['Dashboard']]
    end
  end
  get '/my/dashboard' => Dashboard
end
