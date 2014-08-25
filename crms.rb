require_relative'rolodex'
require 'data_mapper'
require 'sinatra'

DataMapper.setup(:default, "sqlite3:database.sqlite3")

class Contact
	include DataMapper::Resource 

	property :id, Serial
	property :first_name, String
	property :last_name, String
	property :email, String
	property :note, String
end

DataMapper.finalize
DataMapper.auto_upgrade!

  # attr_accessor :id, :first_name, :last_name, :email, :note

  # def initialize(first_name, last_name, email, note)
  #   @first_name = first_name
  #   @last_name = last_name
  #   @email = email
  #   @note = note
  # end

@@rolodex = Rolodex.new

get '/' do
	@crm_app_name = "Come join Kenneth for some Shisha and code!"
	erb :index
end

get '/form' do
	erb :form, :layout => :minimal
end

get "/contacts" do
	erb :contacts
end

get "/contacts/new" do
	erb :new_contact
end

get "/contacts/:id/edit" do
  @contact = @@rolodex.find(params[:id].to_i)
  if @contact
    erb :edit_contact
  else
    raise Sinatra::NotFound
  end
end

post '/contacts' do
	new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
	@@rolodex.add_contact(new_contact)

	redirect to('/')
end

get '/contacts/:id' do
	@contact = @@rolodex.find(params[:id].to_i)
	if @contact
		erb :show_contacts
	else
		raise Sinatra::NotFound
	end
end

 put "/contacts/:id" do
  @contact = @@rolodex.find(params[:id].to_i)
  if @contact
    @contact.first_name = params[:first_name]
    @contact.last_name = params[:last_name]
    @contact.email = params[:email]
    @contact.note = params[:note]

    redirect to('/')
  else
    raise Sinatra::NotFound
  end
end

delete "/contacts/:id" do
  @contact = @@rolodex.find(params[:id].to_i)
  if @contact
    @@rolodex.remove_contact(@contact)

    redirect to('/')
  else
    raise Sinatra::NotFound
   end
end