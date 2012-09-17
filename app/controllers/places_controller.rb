class PlacesController < InheritedResources::Base
  before_filter :authenticate_user!, except: [:map, :create, :new]
  before_filter :set_origin, except: [:map]

  layout "admin", except: [:map]

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
    #TODO: FFS, CLEAN THIS SHIT UP!

    @types = [['startup', 'Startups'],
              ['accelerator', 'Accelerators'],
              ['incubator', 'Incubators'],
              ['coworking', 'Coworking'],
              ['investor', 'Investors'],
              ['service', 'Consulting']]

    gon.places = []

    @types.each do |type|
      Place.where(approved: 1, type: type[0]).order_by(:title.asc).each do |value|
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

  def admin
    @places = Place.all 
    render "index"
  end

  protected

  def set_origin
    @origin = "non-modal"
  end
end
