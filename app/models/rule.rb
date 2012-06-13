class Rule < ActiveRecord::Base
  attr_accessible :name, :type, :xpath, :regex, :token, :modifier, :field_name
  has_many :rules
  
  def getUrls(doc)
  	# if xpath matches something then apply regex and return [value_after_regex]
  	# else return []
  	value = (doc/self.xpath)[0].innerHTML
  	
  end

  def get_urls(doc)
    # while xpath_with_token_replaced_by_modifier matches url
    # add url to returnValues[] array
  end

  def name_values(doc)
		nvs = Array.new

  	# if xpath matches something
  	value = (doc/self.xpath)[0].innerHTML
  	
  	# then apply regex and return [:field, value_after_regex]
  	value = /self.regex/.match(value)
  	
  	# then push field, value
		nvs.push([self.field, value])
		return nvs		
  end  
end
