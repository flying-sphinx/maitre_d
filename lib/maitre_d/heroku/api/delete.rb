class MaitreD::Heroku::API::Delete < MaitreD::Heroku::API::Authenticated
  def call
    response.body = listener.deprovision resource_id

    super
  end

  private

  def resource_id
    request.path[%r{resources/(\d+)}, 1]
  end
end
