class DrilldownRule < Rule
  attr_accessible :type, :xpath, :regex
  def getUrls(doc)
  	# if xpath matches something then apply regex and return [value_after_regex]
  	# else return []
  	value = (doc/self.xpath)[0].innerHTML
  end
end
