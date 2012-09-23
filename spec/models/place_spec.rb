require 'spec_helper'

describe Place do
  before :each do
    Place.any_instance.stub(:geocode).and_return([1,1])
    @place = FactoryGirl.create :startup
  end

  describe "event?" do
    it "returns true if type is an event" do
      @place = FactoryGirl.create :event
      @place.event?.should be_true
    end

    it "returns false if type is not an event" do
      @place.event?.should be_false
    end
  end

  describe "status" do
    it "returns 'Approved' if approved is true" do
      @place = FactoryGirl.create :startup, :approved_trait
      @place.status.should == "Approved"
    end

    it "returns 'Pending' if approved is false" do
      @place = FactoryGirl.create :startup, :pending_trait
      @place.status.should == "Pending"
    end
  end

  describe "ensure_country" do
    it "appends ', Philippines' to the address" do
      @place.address.should include(", Philippines")
    end
  end

  describe "plot_coordinates" do
    it "assigns a value to lat" do
      @place.lat.should_not be_blank
    end

    it "assigns a value to lng" do
      @place.lng.should_not be_blank
    end
  end

  describe "geocode_if_required" do
    before(:each) do
      @place = FactoryGirl.build :startup
    end

    it "assigns default coordinate value to lng if lng does not have a value" do
      expect {
        @place.save
      }.to change(@place, :lng).from(nil).to(@place.coordinates[0])
    end

    it "assigns default coordinate value to lat if lat does not have a value" do
      expect {
        @place.save
      }.to change(@place, :lat).from(nil).to(@place.coordinates[1])
    end

    it "assigns lat and lng values to coordinates" do
      @place.lat = 11.0
      @place.lng = 10.0
      expect {
        @place.save
      }.to change(@place, :coordinates).from([0.0, 0.0]).to([@place.lng, @place.lat])
    end

  end

end
