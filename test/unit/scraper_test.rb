require 'test_helper'

class ScraperTest < ActiveRecord::TestCase
  test "scrape" do
  	@myscraper = Scraper.find_by_name("Kaggle")
  	puts YAML::dump(@myscraper)
		@myscraper.doit
  	
  	
		# challenge = scraper.scrape!
#  	assert_equal(challenge.title, "GigaOM WordPress Challenge, Powered by Splunk")
  end
end


