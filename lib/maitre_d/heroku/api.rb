class MaitreD::Heroku::API
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
      api.connect :get,    %r{/resources/\d+}, MaitreD::Heroku::API::SSO
      api.connect :post,   '/resources',       MaitreD::Heroku::API::Create
      api.connect :put,    %r{/resources/\d+}, MaitreD::Heroku::API::ChangePlan
      api.connect :delete, %r{/resources/\d+}, MaitreD::Heroku::API::Delete
    end
  end
end

require 'maitre_d/heroku/api/authenticated'
require 'maitre_d/heroku/api/change_plan'
require 'maitre_d/heroku/api/create'
require 'maitre_d/heroku/api/delete'
require 'maitre_d/heroku/api/sso'
