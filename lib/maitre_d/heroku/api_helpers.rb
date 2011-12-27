module MaitreD::Heroku::APIHelpers
  def authenticate!
    error!('401 Unauthorized', 401) unless valid_authorization?
  end

  private

  def valid_authorization?
    valid_authorization == env['HTTP_AUTHORIZATION']
  end

  def valid_authorization
    encoded_authorization = Base64.encode64(
      "#{MaitreD::Heroku.id}:#{MaitreD::Heroku.password}"
    )
    "Basic #{encoded_authorization}"
  end
end
