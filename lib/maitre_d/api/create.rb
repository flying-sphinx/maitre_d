class MaitreD::API::Create < MaitreD::API::Authenticated
  def call
    response.body = listener.provision(params)

    super
  end
end
