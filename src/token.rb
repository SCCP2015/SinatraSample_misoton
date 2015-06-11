require "data_mapper"

class Token 
  include DataMapper::Resource

  property :id, Serial
  property :user_id, String
  property :token, String
  property :time, String
end

DataMapper.finalize
