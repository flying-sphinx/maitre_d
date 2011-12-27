require 'spec_helper'

describe 'Heroku Provisioning API' do
  let(:json_response) { JSON.parse response.body }

  describe 'Subscription' do
    it "returns a 401 if the HTTP authorisation does not match" do
      post '/heroku/resources',
        {:plan => '', :callback_url => '', :heroku_id => ''},
        {'HTTP_AUTHORIZATION' => 'Basic foobarbaz'}

      response.status.should == 401
    end
  end
end
