module MaitreD::Heroku::APIHelpers
  def authenticate!
    error!('401 Unauthorized', 401) unless valid_authorization?
  end

  def listener
    MaitreD::Heroku.listener.new
  end

  def provider_id
    params[:heroku_id]
  end

  def session
    env['rack.session']
  end

  def valid_timestamp?
    params[:timestamp].to_i >= (Time.now - 5*60).to_i
  end

  def valid_token?
    expected_token == params[:token]
  end

  private

  def expected_token
    @expected_token ||= Digest::SHA1.hexdigest(
      "#{params[:id]}:#{MaitreD::Heroku.sso_salt}:#{params[:timestamp]}"
    ).to_s
  end

  def valid_authorization?
    valid_authorization.strip == env['HTTP_AUTHORIZATION'].strip
  end

  def valid_authorization
    encoded_authorization = Base64.encode64(
      "#{MaitreD::Heroku.id}:#{MaitreD::Heroku.password}"
    )
    "Basic #{encoded_authorization}"
  end
end
