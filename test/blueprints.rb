require 'machinist/active_record'

Rule.blueprint do
	name { "Default Populate Rule" }
	type { "populate"	}
	xpath { "/html/body/div[3]/div[3]/div/p[2]" }
	regex { "" }
	token { "" }
	modifier { -1 }
	field_name { "description" }
end

Rule.blueprint(:drilldown) do
	name { "Default Drilldown Rule" }
	type { "drilldown"	}
	xpath { "/html/body/div[3]/div[TOKEN]/div/p[2]" }
	regex { "" }
	token { "TOKEN" }
	modifier { 4 }
	field_name { "" }
end

Rule.blueprint(:tree) do
	name { "Default Root Rule" }
	type { "drilldown"	}
	xpath { "/html/body/div[3]/div[TOKEN]/div/p[2]" }
	regex { "" }
	token { "TOKEN" }
	modifier { 4 }
	field_name { "" }
	rule { Rule.make }
end

Challenge.blueprint do 
  title { "Challenge #{sn}" }
#   url_id { Url.make }
	award { "$3,000,000" }
	deadline { "April 30th, 2013" }
	post_date { "April 30th, 2013" }
	image { "http://psychicblast.com/images/1/Image0169.jpg" }
	rules { "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce eu mi odio. Nunc pellentesque varius dignissim. Vivamus id lorem diam. Curabitur congue imperdiet metus id fringilla. Sed et erat tellus, et tempus mi. Donec sodales massa eget metus interdum adipiscing. Duis nisl velit, tempor id consectetur non, vestibulum sit amet mi. Donec enim erat, tincidunt vel suscipit ac, lacinia quis erat. Pellentesque laoreet facilisis risus ut tincidunt. Ut massa orci, gravida non fringilla ornare, posuere nec quam. Mauris tempus rutrum vulputate." }
end
   
