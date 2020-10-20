class MaitreD::API::SSO
  include Sliver::Action

  def self.guards
    [MaitreD::API::SSOGuard]
  end

  def call
    hash = listener.single_sign_on params['resource_id']

    hash[:session] ||= {}
    hash[:session].each { |key, value| session[key] = value }

    if environment['action_dispatch.cookies']
      environment['action_dispatch.cookies']['heroku-nav-data'] =
        params['nav-data']
    else
      Rack::Utils.set_cookie_header! response.headers, 'heroku-nav-data',
        :value => params['nav-data']
    end

    response.status    = 302
    response.body      = ["Redirect to #{hash[:uri]}"]
    response.headers ||= {}
    response.headers['Location'] = hash[:uri]
  end

  def configuration
    environment['maitre_d.configuration']
  end

  private

  def listener
    configuration.listener.new
  end

  def params
    request.params
  end

  def session
    environment['rack.session'] ||= {}
  end
end
