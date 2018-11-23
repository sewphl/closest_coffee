require_relative "../../lib/closest_coffee/scraper.rb"
require_relative "../../lib/closest_coffee/shop.rb"
require_relative "../../lib/closest_coffee/helper.rb"
require 'nokogiri'
require 'colorize'
require 'pry'

class ClosestCoffee::CLI
    
    def run
        ##puts Dir.pwd
        get_coffee
        myCLI
    end

    def get_coffee
        shop_array = ClosestCoffee::Scraper.getme
        ClosestCoffee::Shop.create_from_collection(shop_array)
    end
    
    def myCLI
        puts "It's not always sunny in Philadelphia.\nEnter your zipcode for a list of Eater's favorite Philly coffee shops, ordered by distance from you:\n\n".colorize(:blue)
        puts "Note: Some helpful zipcodes if you're visiting:\n\n19104 for University City,\n19125 for Fishtown/Kensington,\n19107 for Chinatown, or\n19147 for Queen Village/Bella Vista/Italian Market:".colorize(:red) + "\n\n"
        myzip = gets.strip
        until ClosestCoffee::Helper.valid_zip(myzip)
            puts "Please enter a valid zipcode.".colorize(:blue)
            myzip = gets.strip
        end
        puts "Thank you. Generating list...".colorize(:blue)
        myanswer = nil
        myanswer2 = nil
        until myanswer == 1 && myanswer2 == 2
            shopsInOrder = ClosestCoffee::Helper.shops_in_order(ClosestCoffee::Helper.zip_to_lat_lng(myzip)[0],ClosestCoffee::Helper.zip_to_lat_lng(myzip)[1])
            shopsInOrder.each_with_index do |shop, idx|
                puts (idx+1).to_s + ". " + shop.name + ": " + shop.dist.round(1).to_s + " miles away"
            end
            puts "Which of the shops above are you interested in? Please enter the number (from 1 to 22):".colorize(:blue)
            mychoice = (gets.strip.to_i - 1)
            until (0..21).to_a.include? mychoice do
                puts "Please enter a number between 1 and 22.".colorize(:blue)
                mychoice = (gets.strip.to_i - 1)
            end
            puts "Shop of choice: ".colorize(:blue) + shopsInOrder[mychoice].name + "\n\n"
            puts "Here's what Eater has to say: ".colorize(:blue) + shopsInOrder[mychoice].desc + "\n\n"
            puts "Still interested in this shop? 1 for yes, 2 for no.".colorize(:blue)
            myanswer = gets.strip.to_i
            until [1,2].include? myanswer do
                puts "Please enter a 1 or a 2.".colorize(:blue)
            myanswer = gets.strip.to_i
            end
            if myanswer == 2
                puts "No problem, we'll take you back to the list. Generating list...".colorize(:blue)
            elsif myanswer == 1
                puts "Great, here's its contact info:".colorize(:blue) + "\n\n"
                puts "Website: ".colorize(:blue) + shopsInOrder[mychoice].web
                puts "Address: ".colorize(:blue) + shopsInOrder[mychoice].addr
                puts "Phone: ".colorize(:blue) + shopsInOrder[mychoice].phone + "\n\n"
                puts "Would you like to revist the list? 1 for yes, 2 for no.".colorize(:blue)
                myanswer2 = gets.strip.to_i
                until [1,2].include? myanswer2 do
                    puts "Please enter a 1 or a 2.".colorize(:blue)
                    myanswer2 = gets.strip.to_i
                end
                puts "Great, we'll take you back to the list. Generating list...".colorize(:blue) if myanswer2 == 1
            end
        end
        puts "Great, enjoy your drink at #{shopsInOrder[mychoice].name}!".colorize(:blue)
    end
end
