class MaitreD::Broadstack::API < Grape::API
  helpers MaitreD::Broadstack::APIHelpers

  resources :sso do
    post do
      error!('403 Forbidden', 403) unless valid_token? && valid_timestamp?

      hash = listener.single_sign_on(params[:id])

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
  end

  resources :resources do
    post do
      authenticate!

      listener.provision(
        provider_id,            params[:plan],          params[:region],
        params[:callback_url],  params[:logplex_token], params[:options]
      )
    end

    put ':id' do
      authenticate!

      listener.plan_change(
        params[:id], provider_id, params[:plan]
      )
    end

    delete ':id' do
      authenticate!

      listener.deprovision params[:id]
    end
  end
end