class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :update_settings

  def after_sign_in_path_for(resource)
    admin_path
  end

  def update_settings
    @global_settings = Setting.first
  end
end
