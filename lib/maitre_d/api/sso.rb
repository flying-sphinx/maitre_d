class MaitreD::API::SSO
  include Sliver::Action

  def skip?
    return false if valid_token? && valid_timestamp?

    response.status = 403
    response.body   = ['403 Forbidden']
    response.headers['Content-Length'] = response.body.first.length.to_s

    true
  end

  def call
    hash = listener.single_sign_on params['id']

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

  private

  def configuration
    environment['maitre_d.configuration']
  end

  def expected_token
    @expected_token ||= Digest::SHA1.hexdigest(
      "#{params['id']}:#{configuration.sso_salt}:#{params['timestamp']}"
    ).to_s
  end

  def listener
    configuration.listener.new
  end

  def params
    request.params
  end

  def session
    environment['rack.session'] ||= {}
  end

  def valid_timestamp?
    params['timestamp'].to_i >= (Time.now - 5*60).to_i
  end

  def valid_token?
    expected_token == params['token']
  end
end
