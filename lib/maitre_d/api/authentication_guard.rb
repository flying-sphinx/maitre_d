class MaitreD::API::AuthenticationGuard < Sliver::Hook
  def continue?
    valid_authorization?
  end

  def respond
    response.status = 401
    response.body   = ['401 Unauthorized']
    response.headers['Content-Length'] = response.body.first.length.to_s
  end

  private

  def expected_credentials
    "#{action.configuration.id}:#{action.configuration.password}"
  end

  def provided_credentials
    Base64.decode64 action.request.env['HTTP_AUTHORIZATION'].gsub(/^Basic /, '')
  end

  def valid_authorization?
    provided_credentials == expected_credentials
  end
end
