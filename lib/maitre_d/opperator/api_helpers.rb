module MaitreD::Opperator::APIHelpers
  def authenticate!
    error!('401 Unauthorized', 401) unless matching_secret?
  end

  private

  def matching_secret?
    MaitreD::Opperator.shared_secret == env['X-Opperator-Shared-Secret']
  end
end
