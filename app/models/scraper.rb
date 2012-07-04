class Scraper < ActiveRecord::Base
  attr_accessible :name, :url_id, :site_id
  belongs_to :site
  has_one :rule
  
  def doit
  	puts "test"
  end

  def scrape!(challenge)
  	#	foreach rule that returns name value pair, set the value in Challenge
		# for each url returned by rules use factory to create child scraper that matches url
		# pass Challenge object for population to all children scrapers
  end
end
