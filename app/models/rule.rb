class Rule < ActiveRecord::Base
  attr_accessible :type, :xpath, :regex
  
  def self.abstract_class?
    true
  end
  def getUrls(html)
  	return []
  end
  def getNameValues(html)
  	return []
  end
end

class IterateRule < Rule
  attr_accessible :type, :xpath  :regex, :token, :modifier
  def getUrls(html)
    # while xpath_with_token_replaced_by_modifier matches url
    # add url to returnValues[] array
  end
end

class PopulateRule < Rule
  attr_accessible :type, :xpath, :regex, :field
  def getNameValues(html)
  	# if xpath matches something then apply regex and return [:field, value_after_regex]
  	# else return []
  end
end

class DrilldownRule < Rule
  attr_accessible :type, :xpath, :regex
  def getUrls(html)
  	# if xpath matches something then apply regex and return [value_after_regex]
  	# else return []
  end
end
