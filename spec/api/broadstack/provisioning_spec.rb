require 'spec_helper'

describe 'Broadstack Provisioning API' do
  let(:authorisation) { "Basic #{Base64.encode64('foo:bar')}" }
  let(:json_response) { JSON.parse response.body }

  describe 'Provisioning' do
    let(:params) {
      {
        :plan         => 'basic',
        :callback_url => 'https://domain/vendor/apps/app123%40broadstack.com',
        :broadstack_id    => 'app123@broadstack.com'
      }
    }

    it "returns a 401 if the HTTP authorisation does not match" do
      post '/broadstack/resources', params,
        {'HTTP_AUTHORIZATION' => 'Basic foobarbaz'}

      response.status.should == 401
    end

    it "returns the resource id" do
      post '/broadstack/resources', params, {'HTTP_AUTHORIZATION' => authorisation}

      json_response['id'].should == '123'
    end

    it "returns the resource configuration" do
      post '/broadstack/resources', params, {'HTTP_AUTHORIZATION' => authorisation}

      json_response['config'].should == {'FOO_PROVISIONED' => "true"}
    end

    it "returns a custom message" do
      post '/broadstack/resources', params, {'HTTP_AUTHORIZATION' => authorisation}

      json_response['message'].should == 'Add-on provisioned!'
    end

    it "returns the region if it exists" do
      post '/broadstack/resources', params.merge(:region => 'us-west'),
        {'HTTP_AUTHORIZATION' => authorisation}

      json_response['region'].should == 'us-west'
    end
  end

  describe 'Changing Plans' do
    let(:params) {
      {:broadstack_id => 'app123@broadstack.com', :plan => 'premium'}
    }

    it "returns a 401 if the HTTP authorisation does not match" do
      put '/broadstack/resources/7', params,
        {'HTTP_AUTHORIZATION' => 'Basic foobarbaz'}

      response.status.should == 401
    end

    it "returns the new resource configuration" do
      put '/broadstack/resources/7', params, {'HTTP_AUTHORIZATION' => authorisation}

      json_response['config'].should == {'FOO_PROVISIONED' => "false"}
    end

    it "returns a custom message" do
      put '/broadstack/resources/7', params, {'HTTP_AUTHORIZATION' => authorisation}

      json_response['message'].should == 'Add-on upgraded or downgraded.'
    end
  end

  describe 'Deprovisioning' do
    it "returns a 401 if the HTTP authorisation does not match" do
      delete '/broadstack/resources/28', {},
        {'HTTP_AUTHORIZATION' => 'Basic foobarbaz'}

      response.status.should == 401
    end

    it "returns with a status of 200" do
      delete '/broadstack/resources/28', {}, {'HTTP_AUTHORIZATION' => authorisation}

      response.status.should == 200
    end

    it "returns a custom message" do
      delete '/broadstack/resources/28', {}, {'HTTP_AUTHORIZATION' => authorisation}

      json_response['message'].should == 'Add-on removed.'
    end
  end
end
