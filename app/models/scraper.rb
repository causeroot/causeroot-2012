class Scraper < ActiveRecord::Base
  attr_accessible :name, :rule_id, :site_id, :url_id
	belongs_to :site
	has_one :rule
	
	def scrape(challenge)
		if rule.type == "populate"
			challenge[rule.field_name] = rule.get_value
		elseif rule.type == "index"
			rule.get_urls.each do |url|
				rule = Rule.find_by_url(url)
				#rule.
			end
		end
	end  
end
