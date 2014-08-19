require_relative'rolodex'
require_relative 'contact'
require 'sinatra'

@@rolodex = Rolodex.new

get '/' do
	@crm_app_name = "see our em"
	erb :index
end

get "/contacts/new" do
	erb :new_contact
end
# get "/contacts" do
# 	@contacts = []
# 	@contacts << Contact.new("Mr", "T", "mrt@live.ca", "tman")
# 	@contacts << Contact.new("Randy", "Orton", "randyorton@live.ca", "exuviax")
# 	@contacts << Contact.new("Fire", "Man", "fireman@live.ca", "wayne")

# 	erb :contacts
# end