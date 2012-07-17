class Rule < ActiveRecord::Base
  attr_accessible :field_name, :name, :regex, :url_id, :rule_id, :type, :xpath
	has_many :rules
	
	def get_urls(doc)
		# while xpath_with_token_replaced_by_modifier matches url
		# add url to returnValues[] array
		urls = Array.new
		(doc/self.xpath).each do |link|
			urls << link.attributes['href']
		end
		return urls
	end
	
	def extract_value(doc)
		value = (doc/self.xpath)[0].innerHTML
		
		# then apply regex and return [:field, value_after_regex]
		value = /self.regex/.match(value)
		
		return value
	end  
end
