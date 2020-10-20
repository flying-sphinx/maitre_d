require 'spec_helper'

describe 'Heroku SSO API', :type => :request do
  let(:timestamp) { Time.now.to_i }
  let(:nav_data)  { 'heroku-nav-data-goes-here' }
  let(:token)     {
    pre_token = "789:#{MaitreD::Heroku.sso_salt}:#{timestamp.to_s}"
    Digest::SHA1.hexdigest(pre_token).to_s
  }

  it "renders a 403 if the token is incorrect" do
    post '/heroku/resources/sso', :params => {
      :resource_id => '789', :resource_token => 'foo', :timestamp => timestamp,
      'nav-data' => nav_data
    }

    expect(response.status).to eq(403)
  end

  it "renders a 403 if the timestamp is older than 5 minutes" do
    timestamp = 5.minutes.ago.to_i - 1
    pre_token = "789:#{MaitreD::Heroku.sso_salt}:#{timestamp.to_s}"
    token     = Digest::SHA1.hexdigest(pre_token).to_s

    post '/heroku/resources/sso', :params => {
      :resource_id => '789', :resource_token => token, :timestamp => timestamp,
      'nav-data' => nav_data
    }

    expect(response.status).to eq(403)
  end

  it "sets the heroku nav data cookie" do
    post '/heroku/resources/sso', :params => {
      :resource_id => '789', :resource_token => token, :timestamp => timestamp,
      'nav-data' => nav_data
    }

    expect(cookies['heroku-nav-data']).to eq(nav_data)
  end

  it "redirects to the appropriate URL" do
    post '/heroku/resources/sso', :params => {
      :resource_id => '789', :resource_token => token, :timestamp => timestamp,
      'nav-data' => nav_data
    }

    expect(response).to redirect_to('/my/dashboard')
  end

  it "should set the provided session variables" do
    post '/heroku/resources/sso', :params => {
      :resource_id => '789', :resource_token => token, :timestamp => timestamp,
      'nav-data' => nav_data
    }

    expect(session[:app_id]).to eq('789')
  end
end
