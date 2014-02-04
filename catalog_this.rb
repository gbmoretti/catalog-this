require 'sinatra'
require 'sinatra/json'
require 'sinatra/base'
require 'json'
require 'redcarpet'
require 'redis'
require 'pry'

require_relative 'app/cataloger'


class CatalogThis < Sinatra::Base

  get '/' do
    markdown :index
  end

  post '/catalog/' do
    link = Cataloger.catalog(params[:link])
    json link
  end

end

CatalogThis.run!