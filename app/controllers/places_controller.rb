class PlacesController < InheritedResources::Base

  def map
    # For the love of all that is Ruby, CLEAN THIS SHIT UP!

    @types = [['startup', 'Startups'],
              ['accelerator', 'Accelerators'],
              ['incubator', 'Incubators'],
              ['coworking', 'Coworking'],
              ['investor', 'Investors'],
              ['service', 'Consulting']]

    gon.places = []
    place = []

    Place.all.each do |value|
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
