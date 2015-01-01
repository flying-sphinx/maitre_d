class MaitreD::API
  def initialize(configuration = MaitreD::Heroku)
    @configuration = configuration
  end

  def call(environment)
    environment['maitre_d.configuration'] = configuration

    endpoints.call environment
  end

  private

  attr_reader :configuration

  def endpoints
    @endpoints ||= Sliver::API.new do |api|
      api.connect :get,    %r{/resources/\d+}, MaitreD::API::SSO
      api.connect :post,   '/resources',       MaitreD::API::Create
      api.connect :put,    %r{/resources/\d+}, MaitreD::API::ChangePlan
      api.connect :delete, %r{/resources/\d+}, MaitreD::API::Delete
    end
  end
end

require 'maitre_d/api/authenticated'
require 'maitre_d/api/change_plan'
require 'maitre_d/api/create'
require 'maitre_d/api/delete'
require 'maitre_d/api/sso'
