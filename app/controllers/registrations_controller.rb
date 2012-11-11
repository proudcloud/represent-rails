class RegistrationsController < Devise::RegistrationsController

  layout "admin"


  protected
  
  def after_update_path_for(resource)
    admin_path 
  end
  
end

