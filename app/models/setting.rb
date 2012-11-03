class Setting
  include Mongoid::Document
  include Mongoid::Paperclip

  has_mongoid_attached_file :logo,
    styles: { logo_style: '222x94>' },
    path: ":rails_root/public/system/:attachment/:id/:style/:filename",
    url: "/system/:attachment/:id/:style/:filename"

  field :site_name
  field :facebook_page
  field :twitter_handle
  field :analytics_snippet, type: String

  validates_presence_of :site_name

end
