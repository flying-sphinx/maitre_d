class MaitreD::API::SSOGuard < Sliver::Hook
  def continue?
    valid_token? && valid_timestamp?
  end

  def respond
    response.status = 403
    response.body   = ['403 Forbidden']
    response.headers['Content-Length'] = response.body.first.length.to_s
  end

  private

  def expected_token
    @expected_token ||= Digest::SHA1.hexdigest(
      "#{params['resource_id']}:#{action.configuration.sso_salt}:#{params['timestamp']}"
    ).to_s
  end

  def params
    action.request.params
  end

  def valid_timestamp?
    params['timestamp'].to_i >= (Time.now - 5*60).to_i
  end

  def valid_token?
    expected_token == params['resource_token']
  end
end
