require "data_mapper"

class User 
  include DataMapper::Resource

  property :id, Serial
  property :user_id, String
  property :name, String
  property :time, String
end

DataMapper.finalize
