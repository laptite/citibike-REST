require 'rubygems'
require 'sinatra'
require 'data_mapper'
require 'haml'
require 'bundler'
require 'debugger'

Bundler.require

Dir.glob('./lib/*.rb') do |model|
  require model
end

module Citibike
  class App < Sinatra::Application
    before do
      json = File.open("data/citibikenyc.json").read
      @data = MultiJson.load(json)
    end

    get '/stations' do
      @stations = Station.all
      haml :index
    end

    get '/stations/new' do
      @stations = Station.new
      haml :new
    end

    get '/stations/edit/1' do
      @stations = Station.get(params[:id])
      haml :edit
    end

    get '/stations/1' do
      @stations = Station.get(params[:id])
      haml :show
    end

    get '/stations/delete/1' do
      @stations = Station.get(params[:id])
      haml :delete
    end

    delete '/stations/1' do
      Station.get(params[:id]).destroy
      redirect '/stations'  
    end

    post '/stations' do
      @stations = Station.new(params[:name])
      if @stations.save
        status 201
        redirect '/stations/' + @stations.id.to_s
      else
        status 400
        haml :new
      end
    end

    put '/stations/:id' do
      @stations = Station.get(params[:id])
      if @stations.update(params[:name])
        status 201
        redirect '/stations/' + params[:id]
      else
        status 400
        haml :edit  
      end
    end

    post '/map' do

      erb :map
    end
    
    DataMapper.auto_upgrade!
  end
end

# "#{params.inspect}"