require "sinatra/base"
require "sinatra/reloader"
require "data_mapper"
require_relative "word"

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, 'postgres://vagrant:vagrant@localhost/myapp')

def printWord(word)
  puts 'id: #{word.id}, msg: #{word.msg}'
end

class MainApp < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/words' do
    words = Word.all.map do |word|
     word.id.to_s + ": #{word.msg}" 
    end
    "[id: msg]\n" + words.join(', ') + "\n"
  end

  get '/words/:id' do
    word = Word.get(params['id'])
    if word then
      "id: #{word.id}, msg: #{word.msg}\n"
    else
      "#{word.id} is not found.\n"
    end
  end
  
  post '/words' do
    word = Word.create(msg: request.body.gets)
    word.id.to_s
  end
  
  put '/words/:id' do
    word = Word.get(params[:id])
    if word then
      "false"
    else
      word.update(msg: request.body.gets)
      "true"
    end
  end

  delete '/words/:id' do
    word = Word.get(params[:id])
    if word then
      "false" 
    else
      word.destroy.to_s
    end
  end
end
