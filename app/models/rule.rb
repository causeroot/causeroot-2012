class Rule < ActiveRecord::Base
  attr_accessible :type, :xpath, :regex
  belongs_to :scraper
end
