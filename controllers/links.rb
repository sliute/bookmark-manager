class BookmarkManager < Sinatra::Base
  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/links' do
    link = Link.create(url: params[:url], title: params[:title])
    params[:tag].split(', ').each do |t|
      link.tags << Tag.first_or_create(tag_name: t)
    end
    link.save
    redirect '/links'
  end
end
