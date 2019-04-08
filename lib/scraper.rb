require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

    MOUNTAINPROJECT = "https://www.mountainproject.com/area/106527199/dougs-roof"

    def self.scrape_mountain_project
      html = open(MOUNTAINPROJECT)
      doc = Nokogiri::HTML(html)
      doc.css('table#left-nav-route-table tr').each do |route|
        difficulty = route.css('.rateYDS').text
        name = route.css('a').text
        url = route.css('a').attr('href').value
        climb = Climb.new(difficulty, name, url)
        # Climb.all << climb
      end
    end

    def self.scrape_details(climb)
      html = open(climb.url)
      doc = Nokogiri::HTML(html)
      doc.css('.description-details').each do |route|
        climb.type = route.css("tr")[0].text.strip.gsub("\n                                ", "")
      end
      doc.css('#route-star-avg').each do |rating|
        climb.star_rating = rating.css('.show-tooltip').text.strip.gsub("\n   ", "")
    end
    end
end
