class IterateRule < Rule
  attr_accessible :type, :xpath, :regex, :token, :modifier

  def get_urls(doc)
    # while xpath_with_token_replaced_by_modifier matches url
    # add url to returnValues[] array
  end
end

