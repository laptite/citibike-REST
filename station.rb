
class Station
  include DataMapper::Resource
  
   property :name,        String
   property :idx,         Serial
   property :timestamp,   DateTime
   property :number,      Integer
   property :free,        Integer
   property :bikes,       Integer
   property :coordinates, Integer
   property :address,     String
   property :lat,         Integer
   property :lng,         Integer
   property :id,          Serial

end


