class ClosestCoffee::Shop

    ##note: all attributes except dist will come from the Scraper.
    ##dist is calculated and added in the Helper class, once the user enters their zipcode.
    attr_accessor :name, :desc, :addr, :phone, :web, :dist

    @@all = []
    
    def initialize(shop_hash)
        shop_hash.each do |key, val|
            ##stackoverflow.com/questions/973452/calling-self-send-iteratively-on-a-hash-argument-to-initialize
            self.send "#{key}=", val
        end
        @@all << self
    end
    
    def self.create_from_collection(shop_array)
        shop_array.each do |shop|
            ClosestCoffee::Shop.new(shop)
        end
    end

    def self.all
        @@all
    end
end
