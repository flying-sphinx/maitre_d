class HerokuListener < MaitreD::Heroku::Listener
  def provision(heroku_id, plan, callback_url, logplex_token, options)
    {
      :id      => '123',
      :config  => {'provisioned' => true},
      :message => 'Add-on provisioned!'
    }
  end

  def plan_change(resource_id, heroku_id, plan)
    {
      :config  => {'modified' => true},
      :message => 'Add-on upgraded or downgraded.'
    }
  end

  def deprovision(resource_id)
    {
      :message => 'Add-on removed.'
    }
  end

  def single_sign_on(resource_id)
    {
      :uri     => '/my/dashboard',
      :session => {:app_id => resource_id}
    }
  end
end
