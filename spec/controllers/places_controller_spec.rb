require 'spec_helper'

describe PlacesController do

  def valid_attributes
    FactoryGirl.attributes_for :startup
  end

  def valid_session
  end

  login_user

  before :each do
    Place.any_instance.stub(:geocode).and_return([1,1])
  end

  describe "GET index" do
    it "assigns all places as @places" do
      place = Place.create! valid_attributes
      get :index, {}, valid_session
      assigns(:places).should eq(Place.all.to_a)
    end
  end

  describe "GET show" do
    it "assigns the requested place as @place" do
      place = Place.create! valid_attributes
      get :show, {:id => place.to_param}, valid_session
      assigns(:place).should eq(place)
    end
  end

  describe "GET new" do
    it "assigns a new place as @place" do
      get :new, {}, valid_session
      assigns(:place).should be_a_new(Place)
    end
  end

  describe "GET edit" do
    it "assigns the requested place as @place" do
      place = Place.create! valid_attributes
      get :edit, {:id => place.to_param}, valid_session
      assigns(:place).should eq(place)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Place" do
        expect {
          post :create, {:place => valid_attributes}, valid_session
        }.to change(Place, :count).by(1)
      end

      it "assigns a newly created place as @place" do
        post :create, {:place => valid_attributes}, valid_session
        assigns(:place).should be_a(Place)
        assigns(:place).should be_persisted
      end

      it "redirects to the created place" do
        post :create, {:place => valid_attributes}, valid_session
        response.should redirect_to(places_path)
      end
    end

  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested place" do
        place = Place.create! valid_attributes
        # Assuming there are no other places in the database, this
        # specifies that the Place created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Place.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => place.to_param, :place => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested place as @place" do
        place = Place.create! valid_attributes
        put :update, {:id => place.to_param, :place => valid_attributes}, valid_session
        assigns(:place).should eq(place)
      end

      it "redirects to the place" do
        place = Place.create! valid_attributes
        put :update, {:id => place.to_param, :place => valid_attributes}, valid_session
        response.should redirect_to(places_path)
      end
    end

    describe "with invalid params" do
      it "assigns the place as @place" do
        place = Place.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Place.any_instance.stub(:save).and_return(false)
        put :update, {:id => place.to_param, :place => {}}, valid_session
        assigns(:place).should eq(place)
      end

    end
  end

  describe "DELETE destroy" do
    it "destroys the requested place" do
      place = Place.create! valid_attributes
      expect {
        delete :destroy, {:id => place.to_param}, valid_session
      }.to change(Place, :count).by(-1)
    end

    it "redirects to the places list" do
      place = Place.create! valid_attributes
      delete :destroy, {:id => place.to_param}, valid_session
      response.should redirect_to(places_url)
    end
  end

end
