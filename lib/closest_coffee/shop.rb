class ClosestCoffee::Shop

    ##note: all attributes except dist will be updated using data generated from the Scraper.
    ##note: dist is calculated and updated once user inputs their zipcode via CLI (added via Helper method, called from CLI).
    attr_accessor :name, :desc, :addr, :phone, :web, :dist

    @@all = []
    
    def initialize(shop_hash)
        shop_hash.each do |key, val|
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
