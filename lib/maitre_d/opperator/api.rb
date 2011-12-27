class MaitreD::Opperator::API < Grape::API
  helpers MaitreD::Opperator::APIHelpers

  before { authenticate! }

  resources :instances do
    post do
      MaitreD::Opperator.subscribe params[:features]
    end

    delete ':id' do
      # MaitreD::Opperator.cancel params[:id]
    end

    put ':id' do
      # MaitreD::Opperator.update params[:id], params[:features]
    end
  end

  resource :plan_warning do
    put ':id' do
      #
    end
  end
end
