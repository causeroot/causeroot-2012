class Scraper < ActiveRecord::Base
  attr_accessible :name, :url, :title_xpath, :description_xpath, :award_xpath, :deadline_xpath, :post_date_xpath, :image_xpath, :url_reference_xpath
end
