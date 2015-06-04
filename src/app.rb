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
    # テーブルwordsの全件を取得(データの見せ方は自由)。
  end

  get '/words/:id' do
    word = Word.get(params['id'])
    if word then
      "id: #{word.id}, msg: #{word.msg}\n"
    else
      "#{word.id} is not found.\n"
    end
    # パラメータidに対応するwordsテーブルのレコード一件を取得。(idとmsgを表示)
    # もし対応するidが無ければエラーメッセージを表示。
  end
  
  post '/words' do
    word = Word.create(msg: request.body.gets)
    word.id.to_s
    # bodyの文字列をmsgとして、新しいwordレコードを一件追加。
    # レスポンスとして追加時のレコードのidを返す。
  end
  
  put '/words/:id' do
    word = Word.get(params[:id])
    if word.nil? then
      "false"
    else
      word.update(msg: request.body.gets)
      "true"
    end
    # パラメータidに対応するwordsテーブルのレコード一件を更新。
    # 成功した場合、"true" 失敗した場合、"false"をレスポンスとして返す。
  end

  delete '/words/:id' do
    word = Word.get(params[:id])
    if word.nil? then
      "false" 
    else
      word.destroy.to_s
    end
    # パラメータidに対応するwordsテーブルのレコード一件を削除。
    # 成功した場合、"true" 失敗した場合、"false"をレスポンスとして返す。
  end
end
