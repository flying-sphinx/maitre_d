class HerokuListener < MaitreD::Heroku::Listener
  def provision(heroku_id, plan, region, callback_url, logplex_token, options)
    {
      :id      => '123',
      :config  => {'FOO_PROVISIONED' => 'true'},
      :message => 'Add-on provisioned!',
      :region  => region
    }
  end

  def plan_change(resource_id, heroku_id, plan)
    {
      :config  => {'FOO_PROVISIONED' => 'false'},
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
