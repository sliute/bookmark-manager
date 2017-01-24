class Tag
  include DataMapper::Resource

  property :id, Serial
  property :tag_name, String

  has n, :links, through: Resource
end
