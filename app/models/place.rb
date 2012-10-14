class Place
  include Mongoid::Document
  include Geocoder::Model::Mongoid

  cache

  field :approved, type: Boolean, default: false 
  field :title
  field :type # startup, accelerator, incubator, coworking, investor, service, event
  field :lat, type: Float
  field :lng, type: Float
  field :address
  field :uri
  field :description
  field :sector
  field :owner_name
  field :owner_email
  field :date, type: Date

  field :coordinates, type: Array, default: [0.0,0.0]

  scope :pending, where(approved: false).order_by(:title.asc)
  scope :startup, where(type: "startup").order_by(:title.asc)
  scope :accelerator, where(type: "accelerator").order_by(:title.asc)
  scope :incubator, where(type: "incubator").order_by(:title.asc)
  scope :coworking, where(type: "coworking").order_by(:title.asc)
  scope :investor, where(type: "investor").order_by(:title.asc)
  scope :service, where(type: "service").order_by(:title.asc)
  scope :event, where(type: "event", :date.gte => Date.today).order_by(:date.asc)
  scope :past_event, where(type: "event", :date.lt => Date.today).order_by(:date.asc)

  validates_presence_of :title, :address, :uri, :description, :owner_name, :owner_email
  validates_presence_of :date, if: :event?

  geocoded_by :address
  before_save :geocode_if_required, :ensure_country

  def event?
    self.type == 'event'
  end

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
