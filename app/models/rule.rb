class Rule < ActiveRecord::Base
  attr_accessible :name, :type, :xpath, :regex, :token, :modifier, :field_name
  has_many :rules
  
  def get_urls(doc)
    # while xpath_with_token_replaced_by_modifier matches url
    # add url to returnValues[] array
  	urls = Array.new
  	(doc/self.xpath).each do |link|
  		urls.push(link.attributes['href'])
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
