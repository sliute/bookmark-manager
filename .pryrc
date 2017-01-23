require 'dm-migrations'
require 'data_mapper'
require 'dm-postgres-adapter'

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, 'postgres://stefanliute@localhost/database_play')

class Student
  include DataMapper::Resource
  property :id, Serial
  property :name, String
end

DataMapper.finalize
# DataMapper.auto_upgrade!
