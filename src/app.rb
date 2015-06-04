require "sinatra/base"
require "sinatra/json"
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
    json(Word.all)
  end

  get '/words/:id' do
    word = Word.get(params['id'])
    if word then
      json(word)
    else
      json(error: "#{word.id} is not found.\n")
    end
  end
  
  post '/words' do
    word = Word.create(msg: request.body.gets)
    word.id.to_s
  end
  
  put '/words/:id' do
    word = Word.get(params[:id])
    if word then
      word.update(msg: request.body.gets)
      "true"
    else
      "false"
    end
  end

  delete '/words/:id' do
    word = Word.get(params[:id])
    if word then
      word.destroy.to_s
    else
      "false"
    end
  end
end
