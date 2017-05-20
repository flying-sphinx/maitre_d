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

  def valid_authorization?
    valid_authorization.strip == action.request.env['HTTP_AUTHORIZATION'].strip
  end

  def valid_authorization
    encoded_authorization = Base64.encode64(
      "#{action.configuration.id}:#{action.configuration.password}"
    )
    "Basic #{encoded_authorization}"
  end
end
