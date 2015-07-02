require "data_mapper"

class Uuid 
  include DataMapper::Resource

  property :id, Serial
  property :uuid, String
  property :user_id, String

end

DataMapper.finalize
