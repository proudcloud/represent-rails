class PlacesController < InheritedResources::Base

  def create
    @place = Place.new params[:place]
    if @place.save
      respond_to do |format|
        format.html { render text: "success" }
      end
    else
      respond_to do |format|
        format.html { render text: "Please fill out all fields" }
      end
    end
  end

  def map
    #TODO: For the love of all that is Ruby, CLEAN THIS SHIT UP!

    @types = [['startup', 'Startups'],
              ['accelerator', 'Accelerators'],
              ['incubator', 'Incubators'],
              ['coworking', 'Coworking'],
              ['investor', 'Investors'],
              ['service', 'Consulting']]

    gon.places = []

    Place.where(approved: 1).order_by(:title.asc).each do |value|
      place = ["#{value.title}", 
              "#{value.type}",
              "#{value.lat}",
              "#{value.lng}", 
              "#{value.description}", 
              "#{value.uri}", 
              "#{value.address}"]
      gon.places.push place
    end

  end

end
