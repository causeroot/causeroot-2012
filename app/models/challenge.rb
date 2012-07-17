class Challenge < ActiveRecord::Base
  attr_accessible :award, :deadline, :description, :image_url_id, :post_date, :rules, :title, :url_id
  
end
