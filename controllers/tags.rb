class BookmarkManager < Sinatra::Base
  get '/tags/:something' do
    tag = Tag.first_or_create(tag_name: params[:something])
    @links = tag ? tag.links : []
    erb :'links/index'
  end
end
