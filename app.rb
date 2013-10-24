require 'sinatra/base'
require "sinatra/reloader"
require 'mongoid'
require 'json'

require_relative 'models/init'

class App < Sinatra::Base

  set :root, File.dirname(__FILE__)
  set :haml, :format => :html5
  configure :development do
    require 'pry'
    register Sinatra::Reloader
  end

  configure do
    Mongoid.load!("./config/mongoid.yml")
  end

  get '/' do
    haml :index
  end

  post '/track/:api_key' do
    pr = Project.find_by(api_key: params[:api_key])
    pr.events.create!(type: params[:type], time: params[:time], properties: JSON.parse(params[:properties]))
  end

end
