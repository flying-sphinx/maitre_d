class MaitreD::API::Authenticated
  include Sliver::Action

  def self.guards
    [MaitreD::API::AuthenticationGuard]
  end

  def call
    response.body     = [MultiJson.dump(response.body)]
    response.status ||= 200
  end

  def configuration
    environment['maitre_d.configuration']
  end

  private

  def listener
    configuration.listener.new
  end

  def params
    @params ||= MultiJson.load request.body.read
  end

  def provider_id
    configuration.provider_id_from params
  end
end
