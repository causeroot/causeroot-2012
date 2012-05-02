require 'rubygems'
require 'mechanize'
require 'hpricot'
require 'date'


class InnocentiveScraper
  @url = 'https://www.innocentive.com/ar/challenge/browse'
  /html/body/div[2]/div[2]/form/div[2]/div[3]/div/div[3]/div/div[2]/div[4]/div[3]/div
  /html/body/div[2]/div[2]/form/div[2]/div[3]/div/div[3]/div/div[2]/div[8]/div[3]/div

  def get_page
    agent = Mechanize.new
    page = agent.get(url)
    scrape(page.content)
  end

  def scrape(html)
    doc = Hpricot(html)
    prex = '/html/body/div[2]/div[2]/form/div[2]/div[3]/div/div[3]/div/div[2]/div['
    # IMAGE
    puts (doc/prex + x + ']/div[2]/img@src')[0].innerHTML

    # TITLE
    puts (doc/prex + x + ']/div[3]/div/a')[0].innerHTML

    # POSTED
    puts (doc/prex + x + ']/div[4]/div')[0].innerHTML

    # DEADLINE
    puts (doc/prex + x + ']/div[5]/div')[0].innerHTML

    # AWARD
    puts (doc/prex + x + '4]/div[6]/div')[0].innerHTML

    # DESCRIPTION
    puts (doc/prex + x + ']/div[9]/div/div/p')[0].innerHTML
  	Challenge.create(:award => award, :title => title ).  
  end

# 


#/html/body/div[2]/div[2]/form/div[2]/div[3]/div/div[3]/div/div[2]/div[8]/div[3]/div/a
#/html/body/div[2]/div[2]/form/div[2]/div[3]/div/div[3]/div/div[2]/div[12]/div[3]/div/a
#/html/body/div[2]/div[2]/form/div[2]/div[3]/div/div[3]/div/div[2]/div[16]/div[3]/div/a

end
