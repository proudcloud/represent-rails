class Place
  include Mongoid::Document
  include Geocoder::Model::Mongoid

  field :approved, type: Boolean, default: false 
  field :title
  field :type # startup, accelerator, incubator, coworking, investor, service 
  field :lat, type: Float
  field :lng, type: Float
  field :address
  field :uri
  field :description
  field :sector
  field :owner_name
  field :owner_email

  field :coordinates, type: Array, default: [0.0,0.0]

  validates_presence_of :title, :address, :uri, :description, :owner_name, :owner_email

  geocoded_by :address
  before_save :geocode_if_required


  def status
    approved ? "Approved" : "Pending"
  end

  def ensure_country
    if self.address.downcase.index("philippines").nil?
      self.address << ", Philippines" # we need this country user defined in the future
    end

  end

  def plot_coordinates
    self.lng = self.coordinates[0]
    self.lat = self.coordinates[1]
  end

  def geocode_if_required
    ensure_country
    if self.lng.blank? || self.lat.blank?
      if geocode
        plot_coordinates
      end
    else
      self.coordinates[0] = self.lng
      self.coordinates[1] = self.lat
    end
  end

end
