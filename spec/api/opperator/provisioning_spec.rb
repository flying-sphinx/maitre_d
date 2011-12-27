require 'spec_helper'

describe 'Opperator Provisioning API' do
  before :each do
    MaitreD::Opperator.stub :shared_secret => 'something-special'
  end

  describe 'Subscription' do
    it "returns a 401 status if the secret does not match" do
      post '/opperator/instances', {'features' => {}},
        {'X-Opperator-Shared-Secret' => 'wrong-secret'}

      response.status.should == 401
    end
  end
end
