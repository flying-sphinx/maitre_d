require 'spec_helper'

describe 'Heroku Provisioning API', :type => :request do
  let(:config)        { MaitreD::Heroku }
  let(:authorisation) {
    "Basic #{Base64.encode64("#{config.id}:#{config.password}")}"
  }
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
      post '/heroku/resources',
        :params => JSON.dump(params),
        :headers => {'HTTP_AUTHORIZATION' => 'Basic foobarbaz'}

      expect(response.status).to eq(401)
    end

    it "returns the resource id" do
      post '/heroku/resources',
        :params => JSON.dump(params),
        :headers => {'HTTP_AUTHORIZATION' => authorisation}

      expect(json_response['id']).to eq('123')
    end

    it "returns the resource configuration" do
      post '/heroku/resources',
        :params => JSON.dump(params),
        :headers => {'HTTP_AUTHORIZATION' => authorisation}

      expect(json_response['config']).to eq({'FOO_PROVISIONED' => "true"})
    end

    it "returns a custom message" do
      post '/heroku/resources',
        :params => JSON.dump(params),
        :headers => {'HTTP_AUTHORIZATION' => authorisation}

      expect(json_response['message']).to eq('Add-on provisioned!')
    end

    it "returns the region if it exists" do
      post '/heroku/resources',
        :params => JSON.dump(params.merge(:region => 'us-west')),
        :headers => {'HTTP_AUTHORIZATION' => authorisation}

      expect(json_response['region']).to eq('us-west')
    end
  end

  describe 'Changing Plans' do
    let(:params) {
      {:heroku_id => 'app123@heroku.com', :plan => 'premium'}
    }

    it "returns a 401 if the HTTP authorisation does not match" do
      put '/heroku/resources/7',
        :params => JSON.dump(params),
        :headers => {'HTTP_AUTHORIZATION' => 'Basic foobarbaz'}

      expect(response.status).to eq(401)
    end

    it "returns the new resource configuration" do
      put '/heroku/resources/7',
        :params => JSON.dump(params),
        :headers => {'HTTP_AUTHORIZATION' => authorisation}

      expect(json_response['config']).to eq({'FOO_PROVISIONED' => "false"})
    end

    it "returns a custom message" do
      put '/heroku/resources/7',
        :params => JSON.dump(params),
        :headers => {'HTTP_AUTHORIZATION' => authorisation}

      expect(json_response['message']).to eq('Add-on upgraded or downgraded.')
    end
  end

  describe 'Deprovisioning' do
    it "returns a 401 if the HTTP authorisation does not match" do
      delete '/heroku/resources/28',
        :headers => {'HTTP_AUTHORIZATION' => 'Basic foobarbaz'}

      expect(response.status).to eq(401)
    end

    it "returns with a status of 200" do
      delete '/heroku/resources/28',
        :headers => {'HTTP_AUTHORIZATION' => authorisation}

      expect(response.status).to eq(200)
    end

    it "returns a custom message" do
      delete '/heroku/resources/28',
        :headers => {'HTTP_AUTHORIZATION' => authorisation}

      expect(json_response['message']).to eq('Add-on removed.')
    end
  end
end
