class MaitreD::Heroku::API < Grape::API
  helpers MaitreD::Heroku::APIHelpers

  before { authenticate! }

  resources :resources do
    post do
      #
    end
  end
end
