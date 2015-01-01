class MaitreD::API::Create < MaitreD::API::Authenticated
  def call
    response.body = listener.provision(
      provider_id,             params['plan'],          params['region'],
      params['callback_url'],  params['logplex_token'], params['options']
    )

    super
  end
end
