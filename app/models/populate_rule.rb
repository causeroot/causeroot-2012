class PopulateRule < Rule
  attr_accessible :type, :xpath, :regex, :field

  def name_values(doc)
		nvs = Array.new

  	# if xpath matches something
  	value = (doc/self.xpath)[0].innerHTML
  	
  	# then apply regex and return [:field, value_after_regex]
  	value = /self.regex/.match(@value)
  	
  	# then push field, value
		nvs.push([self.field, @value)
		return nvs		
  end
end
