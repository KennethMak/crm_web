require_relative 'contact'
require 'sinatra'

get '/' do
	@crm_app_name = "see our em"
	erb :index
end