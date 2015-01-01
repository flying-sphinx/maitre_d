class MaitreD::Heroku::API::ChangePlan < MaitreD::Heroku::API::Authenticated
  def call
    response.body = listener.plan_change(
      resource_id, provider_id, params['plan']
    )

    super
  end

  private

  def resource_id
    request.path[%r{resources/(\d+)}, 1]
  end
end
