require File.join(File.dirname(__FILE__), 'app.rb')

parser = BikeParser.new('http://citibikenyc.com/stations/json')
parser.call

run Citibike::App