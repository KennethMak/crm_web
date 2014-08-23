require_relative'rolodex'
require_relative 'contact'
require 'sinatra'

@@rolodex = Rolodex.new

@@rolodex.add_contact(Contact.new("Johnny", "Bravo", "johnny@bitmakerlabs.com", "Rockstar"))

get '/' do
	@crm_app_name = "Come join Kenneth for some Shisha and code!"
	erb :index
end

get "/contacts" do
	erb :contacts
end

get "/contacts/new" do
	erb :new_contact
end

post '/contacts' do
	new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
	@@rolodex.add_contact(new_contact)
	redirect to('/contacts')
end

get '/contacts/:id' do
	@contact = @@rolodex.find(params[:id].to_i)
	if @contact
		erb :show_contacts
	else
		raise Sinatra::NotFound
	end
end
# get "/contacts" do
# 	@contacts = []
# 	@contacts << Contact.new("Mr", "T", "mrt@live.ca", "tman")
# 	@contacts << Contact.new("Randy", "Orton", "randyorton@live.ca", "exuviax")
# 	@contacts << Contact.new("Fire", "Man", "fireman@live.ca", "wayne")

# 	erb :contacts
# end