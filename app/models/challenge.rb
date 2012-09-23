class Challenge < ActiveRecord::Base
  attr_accessible :award, :deadline, :description, :image_url, :name, :post_date, :rules, :url
  validates :name, :presence => true
end
