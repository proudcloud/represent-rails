require 'spec_helper'

describe SettingsController do

  login_user

  def valid_attributes
    FactoryGirl.attributes_for :setting
  end

  def valid_session
  end

  describe "GET index" do
    it "assigns setting as @setting" do
      setting = FactoryGirl.create :setting
      get :index, {}, valid_session
      assigns(:setting).should eq(setting)
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:setting) { FactoryGirl.create :setting }

      it "updates the requested setting" do
        Setting.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => setting.to_param, :setting => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested setting as @setting" do
        put :update, {:id => setting.to_param, :setting => valid_attributes}, valid_session
        assigns(:setting).should eq(setting)
      end

      it "redirects to the admin page" do
        put :update, {:id => setting.to_param, :setting => valid_attributes}, valid_session
        response.should redirect_to(admin_path)
      end

      it "displays the correct flash message" do
        put :update, {:id => setting.to_param, :setting => valid_attributes}, valid_session
        flash[:notice].should == "Settings updated"
      end
    end

    describe "with invalid params" do
      it "assigns the setting as @setting" do
        setting = FactoryGirl.create :setting
        Setting.any_instance.stub(:save).and_return(false)
        put :update, {:id => setting.to_param, :setting => {}}, valid_session
        assigns(:setting).should eq(setting)
      end
    end
  end

end
