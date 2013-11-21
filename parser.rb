require './station'
require 'typhoeus'  # typhoeus = http library
require 'json'


class BikeParser

  def initialize(file_name)
    @file_name = file_name
  end

  def call
    DataMapper.auto_migrate!
    response = Typhoeus.get(@file_name)
    parsed = JSON.parse(response.body) 

    parsed["stationBeanList"].first.each do |station|
    Station.create(station)
    end

  end
end

#Datamapper creates table automatically based on model and defined columns (model dictate schemas)
#'response' is object. that Typhoeus gives us back. We need to parse JSON file

# In debugger
  # Find out what keys: parsed.keys
  # Find out what keys: parsed["stationBeanList"].first