class Place
  include Mongoid::Document
  include Geocoder::Model::Mongoid

  field :approved, type: Boolean, default: false 
  field :title
  field :type # startup, accelerator, incubator, coworking, investor, service 
  field :lat, type: Float, default: 0.0
  field :lng, type: Float, default: 0.0
  field :address
  field :uri
  field :description
  field :sector
  field :owner_name
  field :owner_email

  field :coordinates, type: Array

  validates_presence_of :title, :address, :uri, :description, :owner_name, :owner_email

  geocoded_by :address
  #before_save :geocode_if_required
  before_save :ensure_country
  before_save :geocode
  before_save :plot_coordinates


  def ensure_country
    if self.address.downcase.index("philippines").nil?
      self.address << ", Philippines"
    end

  end

  def plot_coordinates
    if geocode
      self.lng = self.coordinates[0]
      self.lat = self.coordinates[1]
    end
  end

  def geocode_if_required
    if self.lng.blank? || self.lat.blank?
      if geocode
        plot_coordinates
      end
    end
  end

end
