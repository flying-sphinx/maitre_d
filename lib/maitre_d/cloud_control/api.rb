class MaitreD::CloudControl::API < Grape::API
  helpers MaitreD::CloudControl::APIHelpers

  resources :resources do
    get ':id' do
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

    post do
      authenticate!

      listener.provision(
        provider_id,            params[:plan], params[:callback_url],
        params[:logplex_token], params[:options]
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
