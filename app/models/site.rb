class Site < ActiveRecord::Base
  attr_accessible :name, :url
  has_one :url
  has_many :scrapers
end
