class Place
  include Mongoid::Document

  field :approved, type: Integer, default: 0
  field :title
  field :type
  field :lat, type: Float, default: 0.0
  field :lng, type: Float, default: 0.0
  field :address
  field :uri
  field :description
  field :sector
  field :owner_name
  field :owner_email
end
