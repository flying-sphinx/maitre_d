class OpperatorListener < MaitreD::Opperator::Listener
  def provision(features)
    {
      'id'      => '321',
      'config'  => {'provisioned_for' => 'opperator'}
    }
  end
  
  def deprovision(resource_id)
    #
  end

  def change_plan(resource_id, features)
    #
  end
end
