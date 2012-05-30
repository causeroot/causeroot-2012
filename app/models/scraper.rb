class Scraper < ActiveRecord::Base
  attr_accessible :name, :url, :title_xpath, :description_xpath, :award_xpath, :deadline_xpath, :post_date_xpath, :image_xpath, :url_reference_xpath
  has_many :rules
  
  def populate(challenge)
  	#	foreach rule that returns name value pair, set the value in Challenge
		# for each url returned by rules use factory to create child scraper that matches url
		# pass Challenge object for population to all children scrapers
  end
end
