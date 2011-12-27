require 'spec_helper'

describe 'Heroku Provisioning API' do
  let(:authorisation) { "Basic #{Base64.encode64('foo:bar')}" }
  let(:json_response) { JSON.parse response.body }

  describe 'Provisioning' do
    let(:params) {
      {
        :plan         => 'basic',
        :callback_url => 'https://domain/vendor/apps/app123%40heroku.com',
        :heroku_id    => 'app123@heroku.com'
      }
    }

    it "returns a 401 if the HTTP authorisation does not match" do
      post '/heroku/resources', params,
        {'HTTP_AUTHORIZATION' => 'Basic foobarbaz'}

      response.status.should == 401
    end

    it "returns the resource id" do
      post '/heroku/resources', params, {'HTTP_AUTHORIZATION' => authorisation}

      json_response['id'].should == '123'
    end

    it "returns the resource configuration" do
      post '/heroku/resources', params, {'HTTP_AUTHORIZATION' => authorisation}

      json_response['config'].should == {'provisioned' => true}
    end

    it "returns a custom message" do
      post '/heroku/resources', params, {'HTTP_AUTHORIZATION' => authorisation}

      json_response['message'].should == 'Add-on provisioned!'
    end
  end

  describe 'Changing Plans' do
    let(:params) {
      {:heroku_id => 'app123@heroku.com', :plan => 'premium'}
    }

    it "returns a 401 if the HTTP authorisation does not match" do
      put '/heroku/resources/7', params,
        {'HTTP_AUTHORIZATION' => 'Basic foobarbaz'}

      response.status.should == 401
    end

    it "returns the new resource configuration" do
      put '/heroku/resources/7', params, {'HTTP_AUTHORIZATION' => authorisation}

      json_response['config'].should == {'modified' => true}
    end

    it "returns a custom message" do
      put '/heroku/resources/7', params, {'HTTP_AUTHORIZATION' => authorisation}

      json_response['message'].should == 'Add-on upgraded or downgraded.'
    end
  end

  describe 'Deprovisioning' do
    it "returns a 401 if the HTTP authorisation does not match" do
      delete '/heroku/resources/28', {},
        {'HTTP_AUTHORIZATION' => 'Basic foobarbaz'}

      response.status.should == 401
    end

    it "returns with a status of 200" do
      delete '/heroku/resources/28', {}, {'HTTP_AUTHORIZATION' => authorisation}

      response.status.should == 200
    end

    it "returns a custom message" do
      delete '/heroku/resources/28', {}, {'HTTP_AUTHORIZATION' => authorisation}

      json_response['message'].should == 'Add-on removed.'
    end
  end
end
