# file: app.rb
require 'sinatra/base'
require 'sinatra/reloader'


class Application < Sinatra::Base 
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    # The erb method takes the view file name (as a Ruby symbol)
    # and reads its content so it can be sent 
    # in the response.
    return erb(:index)
  end

  # Declares a route that responds to a request with:
  #  - a GET method
  #  - the path /
  get '/names' do
    # The code here is executed when a request is received and we need to 
    # send a response. 
    names = params[:names]
    # We can return a string which will be used as the response content.
    # Unless specified, the response status code will be 200 (OK).
    return "#{names}"
  end

  get '/hello' do
    name = params[:name]

    return erb(:index)
  end

  post '/submit' do
    name = params[:name] # The value is 'Alice'
    message = params[:message]
    # Do something with `name`...
  
    return "Thanks #{name} you sent this message: #{message}"
  end


  post '/sort-names' do
    names = params[:names] #names = Joe, Alice, Zoe, Julia, Kieran
		

		return names.split(",").sort.join(",")

	end
end