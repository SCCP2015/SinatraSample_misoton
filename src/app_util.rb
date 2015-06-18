require_relative "user"
require_relative "tweet"

module AppUtil extend self

  def registUser(user_id, password)
    User.create(user_id: user_id, password: password) 
  end

  def registTweet(user_id, body, time)
    Tweet.create(user_id: user_id, body: body, time: time)
  end

  def signIn(user_id, password)
    user = User.first(userid: user_id)
    return user
  end

  def loadTimeline(num)
    Tweet.all
  end

end
