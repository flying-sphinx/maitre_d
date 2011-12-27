require 'spec_helper'

describe 'Heroku SSO API' do
  let(:timestamp) { Time.now.to_i }
  let(:nav_data)  { 'heroku-nav-data-goes-here' }
  let(:token)     {
    pre_token = "789:sea salt:#{timestamp.to_s}"
    Digest::SHA1.hexdigest(pre_token).to_s
  }

  it "renders a 403 if the token is incorrect" do
    get '/heroku/resources/789', :token => 'foo',
      :timestamp => timestamp, 'nav-data' => nav_data

    response.status.should == 403
  end

  it "renders a 403 if the timestamp is older than 5 minutes" do
    timestamp = 5.minutes.ago.to_i - 1
    pre_token = "789:sea salt:#{timestamp.to_s}"
    token     = Digest::SHA1.hexdigest(pre_token).to_s

    get '/heroku/resources/789', :token => token,
      :timestamp => timestamp, 'nav-data' => nav_data

    response.status.should == 403
  end

  it "sets the heroku nav data cookie" do
    get '/heroku/resources/789', :token => token,
      :timestamp => timestamp, 'nav-data' => nav_data

    cookies['heroku-nav-data'].should == nav_data
  end

  it "redirects to the appropriate URL" do
    get '/heroku/resources/789', :token => token,
      :timestamp => timestamp, 'nav-data' => nav_data

    response.should redirect_to('/my/dashboard')
  end
  
  it "should set the provided session variables" do
    get '/heroku/resources/789', :token => token,
      :timestamp => timestamp, 'nav-data' => nav_data
    
    session[:app_id].should == '789'
  end
end
