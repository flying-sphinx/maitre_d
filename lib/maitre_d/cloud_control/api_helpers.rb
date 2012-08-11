module MaitreD::CloudControl::APIHelpers
  include MaitreD::Heroku::APIHelpers

  def listener
    MaitreD::CloudControl.listener.new
  end

  def provider_id
    params[:cloudcontrol_id]
  end

  private

  def expected_token
    @expected_token ||= Digest::SHA1.hexdigest(
      "#{params[:id]}:#{MaitreD::CloudControl.sso_salt}:#{params[:timestamp]}"
    ).to_s
  end

  def valid_authorization
    encoded_authorization = Base64.encode64(
      "#{MaitreD::CloudControl.id}:#{MaitreD::CloudControl.password}"
    )
    "Basic #{encoded_authorization}"
  end
end
