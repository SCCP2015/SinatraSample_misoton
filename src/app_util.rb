require_relative "user"
require_relative "tweet"

module AppUtil extend self

  def registUser(user_id, password)
    user = signIn(user_id, password)
    if user[:user_id] == ""
       User.create(user_id: user_id, password: password) 
      return {user_id: user_id, password: password}
    else
      return {user_id: "", password: ""}
    end
  end

  def registTweet(user_id, body, time)
    Tweet.create(user_id: user_id, body: body, time: time)
  end

  def signIn(user_id, password)
    user = User.last(user_id: user_id)
    if user == nil
      return {user_id: "", password: ""}
    end
    if user.password == password
      return {user_id: user.user_id, password: password} 
    else
      return {user_id: user_id, password: ""}
    end
  end

  def loadTimeline(num)
    Tweet.all(:limit => num.to_i, :order => [ :id.desc ])
  end

  def registToken(user_id, token)
    Uuid.create(user_id, token)
  end
end
