require_relative "user"
require_relative "token"

module UserUtil extend self

  # if user_id is exists => 2
  def signupUser(user_id, name)
    return 1
  end

  def generateToken(user_id)
    for i in 0...100 do
      token = Digest::SHA1.hexdigest("#{user_id}#{rand.to_s}")[0..31]
      if !checkToken(user_id, token)
        next
      end
      return token
    end
   
   return nil
  end

  def checkToken(user_id, token)
    if !User.get(user_id: user_id) then
      return 2
    end

    if !Token.get(token: token) then
      return 3 
    end

    return 1
  end

  def userExist?(user_id)
    if !User.get(user_id: user_id) then
      return false
    else
      return true
    end
  end
end
