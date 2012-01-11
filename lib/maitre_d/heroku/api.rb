class MaitreD::Heroku::API < Grape::API
  helpers MaitreD::Heroku::APIHelpers

  resources :resources do
    get ':id' do
      error!('403 Forbidden', 403) unless valid_token? && valid_timestamp?

      hash = MaitreD::Heroku.listener.new.single_sign_on(params[:id])

      hash[:session] ||= {}
      hash[:session].each { |key, value| session[key] = value }

      if env['action_dispatch.cookies']
        env['action_dispatch.cookies']['heroku-nav-data'] = params['nav-data']
      else
        Rack::Utils.set_cookie_header! header, 'heroku-nav-data',
          :value => params['nav-data']
      end

      status 302
      header 'Location', hash[:uri]
    end

    post do
      authenticate!

      MaitreD::Heroku.listener.new.provision(
        params[:heroku_id],     params[:plan], params[:callback_url],
        params[:logplex_token], params[:options]
      )
    end

    put ':id' do
      authenticate!

      MaitreD::Heroku.listener.new.plan_change(
        params[:id], params[:heroku_id], params[:plan]
      )
    end

    delete ':id' do
      authenticate!

      MaitreD::Heroku.listener.new.deprovision params[:id]
    end
  end
end
