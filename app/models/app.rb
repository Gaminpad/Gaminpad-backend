class App < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :admin_user

  validates :admin_user, :presence => true
  validates :name, :presence => true
  validates :url_slug, :presence => true, :uniqueness => true
  validates :url_slug, :format => { :with => /\A[-a-z0-9]+\z/, :on => :create }

  attr_accessible :name, :url_slug, :status
  
end
