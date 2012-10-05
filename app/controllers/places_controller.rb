class PlacesController < InheritedResources::Base
  before_filter :authenticate_user!, except: [:map, :create, :new]
  before_filter :set_origin, except: [:map]

  layout "admin", except: [:map]

 
  def index
    @places = Place.order_by(:title.asc ).all 
  end

  def create
    @place = Place.new params[:place]
    if @place.save
      flash[:notice] = "Thanks, your entry has been submitted and will be reviewed shortly!"
      if current_user
        redirect_to places_path, notice: "Place successfully added."
      else
        redirect_to root_path
      end
    end
  end

  def map
    @place = Place.new

    gon.places = []

    TYPES.each do |type|
      Place.send(type[1].to_sym).where(approved: 1).order_by(:title.asc).each do |value|
        place = ["#{value.title}", 
                "#{value.type}",
                "#{value.lat}",
                "#{value.lng}", 
                "#{value.description}", 
                "#{value.uri}", 
                "#{value.address}",
                "#{value.date}"]
        gon.places.push place
      end
    end

  end

  def admin
    @places = Place.order_by(:title.asc ).all 
    render "index"
  end

  def destroy
    destroy! { places_path }
  end

  def update
    update! { places_path }
  end

  protected

  def set_origin
    @origin = "non-modal"
  end
end
