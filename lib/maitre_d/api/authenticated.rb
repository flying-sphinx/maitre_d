class MaitreD::API::Authenticated
  include Sliver::Action

  def skip?
    return false if valid_authorization?

    response.body   = ['401 Unauthorized']
    response.status = 401
    true
  end

  def call
    response.body     = [MultiJson.dump(response.body)]
    response.status ||= 200
  end

  private

  def configuration
    environment['maitre_d.configuration']
  end

  def listener
    configuration.listener.new
  end

  def params
    request.params
  end

  def provider_id
    configuration.provider_id_from params
  end

  def valid_authorization?
    valid_authorization.strip == environment['HTTP_AUTHORIZATION'].strip
  end

  def valid_authorization
    encoded_authorization = Base64.encode64(
      "#{configuration.id}:#{configuration.password}"
    )
    "Basic #{encoded_authorization}"
  end
end
