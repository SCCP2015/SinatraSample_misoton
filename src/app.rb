require "sinatra/base"
require "sinatra/reloader"
require_relative "database"

class MainApp < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end
  get '/' do
    begin
      Database.instance.readData()
    rescue
      ""
    end
  end
  
  post '/' do
    begin
      body = request.body.gets
      Database.instance.addData(body) 
    rescue => e
     ""
    end
  end

  put '/' do
    begin
      Database.instance.cleanData()
      Database.instance.addData(request.body.gets)
    rescue
      ""
    end
  end

  delete '/' do
    begin
      Database.instance.cleanData()
    rescue
      ""
    end
  end

  get '/echo/:word' do
    "#{params['word']}"
  end

  get '/user/:name/:id/:gender' do
    "Hello, #{params['name']}.Your ID is #{params['id']}.You are #{params['gender']}."
  end

  get '/multiply/:a/:b' do
    "#{params['a']} x #{params['b']} = #{params['a'].to_i * params['b'].to_i}"
  end

end
