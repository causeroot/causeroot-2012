class Rule < ActiveRecord::Base
  attr_accessible :type, :xpath, :regex
  belongs_to :scraper
  
  def self.abstract_class?
    true
  end
  def urls(doc)
  	return []
  end
  def name_values(doc)
  	return []
  end
end

class IterateRule < Rule
  attr_accessible :type, :xpath  :regex, :token, :modifier
  def get_urls(doc)
    # while xpath_with_token_replaced_by_modifier matches url
    # add url to returnValues[] array
  end
end

class PopulateRule < Rule
  attr_accessible :type, :xpath, :regex, :field
  def name_values(doc)
		nvs = Array.new

  	# if xpath matches something
  	value = (doc/self.xpath)[0].innerHTML
  	
  	# then apply regex and return [:field, value_after_regex]
  	
  	# then push field, value
		nvs.push([self.field, self.value)
				
  end
end

class DrilldownRule < Rule
  attr_accessible :type, :xpath, :regex
  def getUrls(doc)
  	# if xpath matches something then apply regex and return [value_after_regex]
  	# else return []
  end
end
