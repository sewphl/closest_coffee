require 'open-uri'
require 'pry'
require 'nokogiri'

class ClosestCoffee::Scraper
    def self.getme
        arr_n = []

        get_coffee = Nokogiri::HTML(open("https://philly.eater.com/maps/best-coffee-shops-philadelphia"))

        doc = get_coffee.css(".c-mapstack__card")
        #for i in (1..24).to_a.except(7,17) ##7 is newsletter and 17 is related-links.
        for i in ((1..6).to_a).concat((8..16).to_a).concat((18..24).to_a)
            shp = {
                name: doc[i].css(".c-mapstack__card-hed h1").text.gsub(/\n\d+\.\ /,"").rstrip,
                desc: doc[i].css(".c-entry-content p").text,
                addr: doc[i].css(".c-entry-content .c-mapstack__info .c-mapstack__address").text.gsub("Philadelphia",", Philadelphia"),
                phone: doc[i].css(".c-entry-content .c-mapstack__info .c-mapstack__phone-url .desktop-only").text.gsub(/^$/,"Sorry, this shop doesn't have a phone."),
                web: doc[i].css(".c-entry-content .c-mapstack__info .c-mapstack__phone-url a")[doc[i].css(".c-mapstack__info .c-mapstack__phone-url a").size-1]["href"].to_s.gsub(/tel:[[:digit:]]+/,"Sorry, this shop doesn't have a website.")
                }
                arr_n << shp
        end
        arr_n
    end
end
