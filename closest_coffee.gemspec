
require "./lib/closest_coffee/version"

Gem::Specification.new do |spec|
    spec.name          = "closest_coffee"
    spec.authors       = ['sewphl']
    spec.version       = ClosestCoffee::VERSION
    spec.files         = ["lib/closest_coffee.rb", "lib/closest_coffee/cli.rb", "lib/closest_coffee/scraper.rb", "lib/closest_coffee/helper.rb", "lib/closest_coffee/shop.rb", "config/environment.rb", "lib/closest_coffee/zips/zips.txt","lib/closest_coffee/version.rb"]
    spec.summary       = "Find the closest coffee shop."

  spec.executables << 'closest_coffee'
  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency 'geokit'
  spec.add_development_dependency 'csv'
  spec.add_development_dependency 'nokogiri'
  spec.add_development_dependency 'open-uri'
end
