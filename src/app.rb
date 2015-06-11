require "sinatra/base"
require "sinatra/json"
require "sinatra/reloader"
require "data_mapper"
require "json"
require_relative "word"
require_relative "user"
require_relative "tweet"
require_relative "follow"
require_relative "token"

require_relative "user_util"

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, 'postgres://vagrant:vagrant@localhost/myapp')

class MainApp < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  post '/signup' do
    body = JSON.parse(request.body.gets)
    i = UserUtil.signupUser(body[:id], body[:name])
    json(i)
    # add user to user_table.
    # detail is read from request body.
    # error: no body, user exist.
  end

  post '/generateToken' do
    json(User.all)
    # generate token string from random function.
    # if it token don't exist, add token record to token_table.
    # error: user token still live.
  end

  get '/user_tweets/:user_id' do
    # select tweet list that post with only one user.
    # error: user_id is not signuped, tweet is not found.
  end

  get '/tweets/:user_id' do
    # select tweet  list that post with :user_id was followed user.
    # error: user_id is not signuped, twet is not found.
  end

  get '/user/:userid' do
    # get :user_id's detail.
    # error: user_id is not signuped.
  end

  get '/tweetdetail/:tweet_id' do
    # get tweet detail that time and user_id.
    # error: :tweet_id is not available.
  end

  get '/timeline/:user_id' do
    # select tweet list that post with :user_id was followed user.
    # error: user_id is not signuped, tweet is not found.
  end

  get '/follows/:user_id' do
    # get user list was followed by :user_id.
    # error: :user_id is not signuped, number of follow equals 0.
  end

  get '/followers/:user_id' do
    # get user list was folloed for :user_id.
    # error: user_id is not signuped, number of follower equals 0.
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
