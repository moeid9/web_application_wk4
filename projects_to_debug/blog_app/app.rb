require 'sinatra/base'
require "sinatra/reloader"
require './lib/post'
require './lib/post_manager'

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/post.rb'
    also_reload 'lib/post_manager.rb'
  end

  before do
    @post_manager = PostManager.instance
  end

  get '/' do
    @posts = @post_manager.all_posts

    return erb(:index)
  end

  # get posts for a given tag
  get '/tag/:tag' do
    @posts = @post_manager.all_posts_by_tag(params[:tag])

    return erb(:index)
  end

  # create new post
  post '/posts' do
    if invalid_request_parameters?
      # Set the response code
      # to 400 (Bad Request) - indicating
      # to the client it sent incorrect data
      # in the request.
      status 400
  
      return ''
    end
    new_post = Post.new(params[:title], params[:content], params[:tags].split(','))
    @post_manager.add_post(new_post)

    return redirect('/')
  end

  def invalid_request_parameters?
    # Are the params nil?
    return true if params[:title] == nil || params[:content] == nil || params[:tags]
  
    # Are they empty strings?
    return true if params[:title] == "" || params[:content] == "" || params[:tags]
  
    return false
  end
end
