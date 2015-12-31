#!/usr/bin/ruby

# thingy to gather information about followers and perform
# follow/unfollow actions

require 'twitter'

# the delay between all actions performed on api
# we are nice to twitter. so nice. that's why this
# follower thing works, you see.
$delay_in_sec = 5

class FollowerThing
  attr_accessor :client

  def initialize(client, username = nil)
    # FEED ME TWITTER CLIENT and optional username to eat
    if !username
      username = client.user.screen_name
    end
    # take back the user
    @username = username

    @
  end

  def follow_parity
    twitter.following.each do |x|
    sleep(3) #be nice to api
    if !x.following?
    twitter.unfollow(x)
    log "Unfollowed #{x.screen_name}"
    end
    end
    twitter.following.each do |x|
    sleep(3) #be nice to api
    if x.following?
    twitter.follow(x)
    log "Followed #{x.screen_name}"
    end
    end
    end
  end

def


# YUMMY EXAMPLE
client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "lN1fHeFIm7LTAKQYV03DDpVNO"
  config.consumer_secret     = "2DviCQ3dDXBBU4csQcbHxcmJwQaoLYCxXDdcGaY7mpCgGabw9a"
  config.access_token        = "2227152482-wJCVN8e0144H1QMLaDAzVVbK8oIeNjbivIg5UXQ"
  config.access_token_secret = "hRJ4xN5wGXGUhMfA3jYh7iwX3quwxr9sX4osUVjTsUdoY"
end
x = FollowerThing.new(client,'negatendo')
