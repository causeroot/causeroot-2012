require "test/unit"
require "lib/innocentive-scraper"

class InnocentiveTest < Test::Unit::TestCase

  # scrape test
  def test_scrape
    html = ''
    File.open("test/fixtures/innocentive.html", "r") { |f|
      html = f.read
    }
    s = InnocentiveScraper.new
    s.scrape(html)
  end
end