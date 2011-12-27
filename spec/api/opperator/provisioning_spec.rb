require 'spec_helper'

describe 'Opperator Provisioning API' do
  let(:json_response) { JSON.parse response.body }

  describe 'Subscription' do
    it "returns a 401 status if the secret does not match" do
      post '/opperator/instances', {'features' => {}},
        {'X-Opperator-Shared-Secret' => 'wrong-secret'}

      response.status.should == 401
    end

    it "returns the instance id" do
      post '/opperator/instances', {'features' => {}},
        {'X-Opperator-Shared-Secret' => 'something-special'}

      json_response['id'].should == '321'
    end

    it "returns a hash of options" do
      post '/opperator/instances', {'features' => {}},
        {'X-Opperator-Shared-Secret' => 'something-special'}

      json_response['config'].should be_a(Hash)
    end
  end

  describe 'Cancellation' do
    it "returns a 401 status if the secret does not match" do
      delete '/opperator/instances/323', {},
        {'X-Opperator-Shared-Secret' => 'wrong-secret'}

      response.status.should == 401
    end
  end

  describe 'Modification' do
    it "returns a 401 status if the secret does not match" do
      put '/opperator/instances/323', {'features' => {}},
        {'X-Opperator-Shared-Secret' => 'wrong-secret'}

      response.status.should == 401
    end
  end

  describe 'Warning' do
    it "returns a 401 status if the secret does not match" do
      put '/opperator/plan_warning/323', {},
        {'X-Opperator-Shared-Secret' => 'wrong-secret'}

      response.status.should == 401
    end
  end
end
