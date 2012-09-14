class PlacesController < InheritedResources::Base

  def map

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
