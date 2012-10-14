require 'spec_helper'

describe Place do
  before :each do
    Place.any_instance.stub(:geocode).and_return([1,1])
    @place = FactoryGirl.create :startup
  end

  context "scopes" do

    describe "pending" do
      it "includes pending places" do
        Place.pending.should include @place
      end

      it "excludes non pending places" do
        @place = FactoryGirl.create :place, :approved_trait
        Place.pending.should_not include @place
      end
    end

    describe "startup" do
      it "includes startups" do
        Place.startup.should include @place
      end

      it "excludes non startups" do
        @place = FactoryGirl.create :incubator
        Place.startup.should_not include @place
      end
    end


    describe "accelerator" do
      it "includes accelerators" do
        @place = FactoryGirl.create :accelerator
        Place.accelerator.should include @place
      end

      it "excludes non accelerators" do
        Place.accelerator.should_not include @place
      end
    end

    describe "incubator" do
      it "includes incubators" do
        @place = FactoryGirl.create :incubator
        Place.incubator.should include @place
      end

      it "excludes non incubators" do
        Place.incubator.should_not include @place
      end
    end

    describe "coworking" do
      it "includes coworkings" do
        @place = FactoryGirl.create :coworking
        Place.coworking.should include @place
      end

      it "excludes non coworkings" do
        Place.coworking.should_not include @place
      end
    end

    describe "investor" do
      it "includes investors" do
        @place = FactoryGirl.create :investor
        Place.investor.should include @place
      end

      it "excludes non investors" do
        Place.investor.should_not include @place
      end
    end

    describe "service" do
      it "includes services" do
        @place = FactoryGirl.create :consulting
        Place.service.should include @place
      end

      it "excludes non services" do
        Place.service.should_not include @place
      end
    end

    describe "event" do
      it "includes events" do
        @place = FactoryGirl.create :event
        Place.event.should include @place
      end

      it "excludes non events" do
        Place.event.should_not include @place
      end

      it "excludes past events" do
        @place = FactoryGirl.create :past_event
        Place.event.should_not include @place
      end
    end

    describe "past_event" do
      it "includes past events" do
        @place = FactoryGirl.create :past_event
        Place.past_event.should include @place
      end

      it "excludes non events" do
        Place.past_event.should_not include @place
      end

      it "excludes future events" do
        @place = FactoryGirl.create :event
        Place.past_event.should_not include @place
      end
    end
  end # end scopes

  context "methods" do

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
        @place = FactoryGirl.create :startup
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

  end # end methods

end
