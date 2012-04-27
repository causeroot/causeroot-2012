class Challenge < ActiveRecord::Base
  attr_accessible :award, :deadline, :description, :discussion_board, :image, :post_date, :title, :url_reference
end
