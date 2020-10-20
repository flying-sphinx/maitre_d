class MaitreD::API::Delete < MaitreD::API::Authenticated
  def call
    response.body = listener.deprovision resource_id

    super
  end

  private

  def resource_id
    request.path[%r{resources/([\w-]+)}, 1]
  end
end
