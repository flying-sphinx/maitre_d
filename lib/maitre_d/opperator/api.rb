class MaitreD::Opperator::API < Grape::API
  helpers MaitreD::Opperator::APIHelpers

  resources :instances do
    before { authenticate! }

    post do
      '200'
    end
  end
end
