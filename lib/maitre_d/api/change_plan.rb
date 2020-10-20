class MaitreD::API::ChangePlan < MaitreD::API::Authenticated
  def call
    response.body = listener.plan_change(
      resource_id, params['plan']
    )

    super
  end

  private

  def resource_id
    request.path[%r{resources/([\w-]+)}, 1]
  end
end
