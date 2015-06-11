module StaticResponse extend self
  PresentationError = "Parameter(s) are incorrect presentation."
  AccessTokenWasKilledError = "Access token was killed."
  UserNotFoundError = "User is not found."
  TweetNotFoundError = "Tweet is not found."
end
