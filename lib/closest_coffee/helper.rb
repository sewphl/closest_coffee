class ClosestCoffee::Helper

filedir = __dir__
##note: this csv comes from https://gist.github.com/erichurst/7882666
CSVTEXT = File.read(filedir + "/zips/zips.txt")
THECSV = CSV.parse(CSVTEXT, :headers => true)

    def self.zip_to_lat_lng(myzip)
    ##returns array of [lat, lng] for zipcode that was entered.
    (THECSV.find {|row| row['ZIP'] == myzip})[1..2]
    end

    def self.shops_in_order(l1,l2)
        ##user's loc
        current_location = Geokit::LatLng.new(l1,l2)
        ClosestCoffee::Shop.all.each do |shop|
            shopLL = zip_to_lat_lng(shop.addr.split(//).last(5).join)
            destination = Geokit::LatLng.new(shopLL[0],shopLL[1])
            ##update dist attribute (distance from user loc) for shop instance.
            shop.dist = current_location.distance_to(destination)
        end
        ##return shop objects in order of distance from user.
        ClosestCoffee::Shop.all.sort_by {|obj| obj.dist}
    end

    def self.valid_zip(value)
    (THECSV.find {|row| row['ZIP'] == value}) != nil
    end
end
