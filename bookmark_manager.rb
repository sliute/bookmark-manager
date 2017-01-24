require 'sinatra/base'
require_relative 'app/models/link'

class BookmarkManager < Sinatra::Base

  ENV["RACK_ENV"] ||= "development"

  get '/' do
    'Hello BookmarkManager!'
  end

  get '/links' do
  @links = Link.all
  erb :'links/index'
  end

  get '/links/new' do
    erb :'links/form'
  end

  post '/links' do
    Link.create(url: params[:url], title: params[:title])
    redirect '/links'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
