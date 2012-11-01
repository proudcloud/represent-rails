class SettingsController < ApplicationController
  before_filter :authenticate_user!
  layout "admin"

  def index
    @setting = Setting.first
  end

  def update
    @setting = Setting.first

    respond_to do |format|
      if @setting.update_attributes(params[:setting])
        format.html {
          redirect_to admin_path, notice: "Settings updated"
        }
      end
    end

  end
end
