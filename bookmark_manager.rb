ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/partial'
require_relative 'data_mapper_setup'

require_relative 'server'
require_relative 'controllers/links'
require_relative 'controllers/sessions'
require_relative 'controllers/tags'
require_relative 'app/send_recover_link'
require_relative 'controllers/users'

class BookmarkManager < Sinatra::Base
  get '/' do
    'Welcome to BookmarkManager v.0.1'
  end

  run! if app_file == $0
end
