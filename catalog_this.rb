ENV['RACK_ENV'] ||= 'development'

require 'sinatra'
require 'sinatra/json'
require 'sinatra/base'
require 'json'
require 'redcarpet'
require 'pry'
require 'dotenv'
require_relative 'app/cataloger'
require_relative 'app/app_infos'

if ENV['RACK_ENV'] != 'production'
  require 'fakeredis'
else
  require 'redis'
end

if ENV['RACK_ENV'] != 'production' ||
  ENV['RACK_ENV'] != 'test'
  Dotenv.load
end

class CatalogThis < Sinatra::Base

  get '/' do
    markdown :index
  end

  post '/catalog/' do
    link = Cataloger.catalog(params[:link])
    json link
  end

  get '/info/' do
    info = AppInfos.get
    json info
  end

  get '/search/' do
    links = Cataloger.search(params)
    json links
  end

end
