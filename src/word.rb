require "data_mapper"

class Word
  include DataMapper::Resource

  property :id, Serial
  property :msg, String
end

DataMapper.finalize
