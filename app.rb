require 'rubygems'
require 'sinatra'
require 'data_mapper'
require 'haml'
require 'bundler'
require './station.rb'
require './parser.rb'

Bundler.require

Dir.glob('./lib/*.rb') do |model|
  require model
end



module Citibike
  class App < Sinatra::Application

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/stations.db")

    # LIST all stations
    get '/stations' do
      @stations = Station.all
      haml :index
    end

    # NEW add station
    get '/stations/new' do
      @stations = Station.new
      haml :new
    end

    # SHOW station
    get '/stations/:id' do
      @stations = Station.get(params[:id])
      haml :show
    end

    # EDIT station
    get '/stations/edit/:id' do
      @stations = Station.get(params[:id])
      haml :edit
    end

    # station DELETE CONFIRMATION
    get '/stations/delete/:id' do
      @stations = Station.get(params[:id])
      haml :delete
    end

    # DELETE station
    delete '/stations/:id' do
      Station.get(params[:id]).destroy
      redirect '/stations'  
    end

    # POST new station
    post '/stations' do
      @stations = Station.new(params[:stationName])
      if @stations.save
        status 201
        redirect '/stations/' + @stations.id.to_s
      else
        status 400
        haml :new
      end
    end

    # UDPATE station
    put '/stations/:id' do
      @stations = Station.get(params[:id])
      if @stations.update(params[:stationName])
        status 201
        redirect '/stations/' + params[:id]
      else
        status 400
        haml :edit  
      end
    end
    
    DataMapper.auto_upgrade!

    # helpers do
    #   def partial template
    #     erb template, :layout => false
    #   end
    # end

  end
end

