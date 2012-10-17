class Challenge < ActiveRecord::Base
  attr_accessible :award, :deadline, :description, :image_url, :name, :post_date, :rules, :url, :xpath
  validates :name, :presence => true
  
  searchable do
	  string :name, :stored => true
    text :description, :stored => true
  end  
end
