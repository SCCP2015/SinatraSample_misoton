require "data_mapper"

class Tweet 
  include DataMapper::Resource

  property :id, Serial
  property :user_id, String
  property :body, String
  property :time, String
end

DataMapper.finalize
