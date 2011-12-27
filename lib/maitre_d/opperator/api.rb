class MaitreD::Opperator::API < Grape::API
  helpers MaitreD::Opperator::APIHelpers

  before { authenticate! }

  resources :instances do
    post do
      MaitreD::Opperator.listener.new.provision params[:features]
    end

    delete ':id' do
      MaitreD::Opperator.listener.new.deprovision params[:id]
    end

    put ':id' do
      MaitreD::Opperator.listener.new.change_plan params[:id], params[:features]
    end
  end

  resource :plan_warning do
    put ':id' do
      #
    end
  end
end
