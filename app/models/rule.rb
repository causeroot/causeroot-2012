class Rule < ActiveRecord::Base
	unloadable
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
