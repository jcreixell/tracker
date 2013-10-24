require 'sinatra/base'
require "sinatra/reloader"
require 'mongoid'
require 'json'

require_relative 'models/init'
require_relative 'helpers/visualization_helper'
require_relative 'lib/metrics/init'

class App < Sinatra::Base

  set :root, File.dirname(__FILE__)
  set :haml, :format => :html5
  set :json_pretty, true

  helpers VisualizationHelper

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
    project = Project.find_by(api_key: params[:api_key])
    project.events.create!(type: params[:type], time: params[:time], properties: JSON.parse(params[:properties]))
  end

  get '/metrics/:api_key/overview' do
    @api_key = params[:api_key]
    @start_date = Date.parse(params['startDate'])
    @end_date = Date.parse(params['endDate'])
    haml :'metrics/overview'
  end

  get '/metrics/:api_key/data/segmentation' do
    content_type :js
    callback = params['callback']
    project = Project.find_by(api_key: params[:api_key])
    start_date = Date.parse(params['startDate'])
    end_date = Date.parse(params['endDate'])
    data = Metrics::Segmentation.new(project, "sale", start_date, end_date).process
    content = encode_chart_data('sales', data)
    "#{callback}(#{content})"
  end

end
