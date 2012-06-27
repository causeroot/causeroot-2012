class Challenge < ActiveRecord::Base
  attr_accessible :title, :url_id, :url_reference, :description, :award, :deadline, :post_date, :image, :rules

end
