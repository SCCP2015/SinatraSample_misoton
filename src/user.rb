require "data_mapper"

class User 
  include DataMapper::Resource

  property :id, Serial
  property :user_id, String
  property :password, String
end

DataMapper.finalize
