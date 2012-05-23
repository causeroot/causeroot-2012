class Challenge < ActiveRecord::Base
  attr_accessible :title, :url_id, :description, :award, :deadline, :post_date, :image, :rules

end
