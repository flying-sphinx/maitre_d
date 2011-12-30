Rails.application.routes.draw do
  class Dashboard
    def self.call(env)
      [200, {'Content-Type' => 'text/plain', 'Content-Length' => '9'},
        ['Dashboard']]
    end
  end
  match '/my/dashboard' => Dashboard
end
