require "sinatra/base"
require "sinatra/json"
require "sinatra/reloader"
require "data_mapper"
require "json"
require_relative "user"
require_relative "tweet"
require_relative "static_response"

require_relative "app_util"

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, 'postgres://admin:admin@localhost/myapp')

class MainApp < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  post '/signup' do
    if !params[:user_id] || !params[:password] then
      return StaticResponse.PresentationError
    end
    user = AppUtil.registUser(params[:user_id], params[:password])
    json(user)
    # add user to user_table.
    # detail is read from request body.
    # error: no body, user exist.
  end

  get '/timeline' do
    json(AppUtil.loadTimeline(params[:tweet_num])) 
  end

  post '/signin' do
  
    user = AppUtil.signIn(params[:user_id], params[:password])
    if user[:password] != "" then
      json({user_id: user[:user_id], password: user[:password]})
    else
      json({user_id: "", password: ""})
    end
  end

  post '/tweet' do
    if AppUtil.signIn(params[:user_id], params[:password]) == nil then
       return json({user_id: "", password: ""})
    end
    AppUtil.registTweet(params[:user_id], params[:body], params[:time])
    return json({user_id: params[:user_id], password: params[:password]})
  end
end
