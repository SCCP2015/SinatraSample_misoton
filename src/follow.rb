require "data_mapper"

class Follow 
  include DataMapper::Resource

  property :id, Serial
  property :user_id, String
  property :follow, String
end

DataMapper.finalize
