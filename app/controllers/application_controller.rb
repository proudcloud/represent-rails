class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from ActionDispatch::Session::SessionRestoreError do |exception|
    reset_session
    redirect_to root_path
  end

end
