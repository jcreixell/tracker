require 'sinatra/base'
require 'mongoid'
require 'pry' if Sinatra::Base.development?

require_relative 'models/init'

class App < Sinatra::Base

	set :root, File.dirname(__FILE__)
	set :haml, :format => :html5

	configure do
	  Mongoid.load!("./config/mongoid.yml")
	end

	get '/' do
	  haml :index
	end

	# post '/track/:api_key' do
	# 	p params
	# 	Project.find_by(api_key: params[:api_key])
	# end

end
