#!/usr/bin/ruby

# thingy to gather information about followers and perform
# follow/unfollow actions

require 'twitter'

# the delay between all actions performed on api
# we are nice to twitter. so nice. that's why this
# follower thing works, you see.
$twitter_client_delay = 5

class FollowerThing
  attr_accessor :client

  attr_reader :follow_parity_running

  def initialize(client, username = nil)
    # FEED ME TWITTER CLIENT and optional username to eat
    @client = client
    if !username
      username = client.user.screen_name
    end
    @delay = $twitter_client_delay

    # take back the user
    @username = username
  end

  def follow_parity

    if @last_command_running
      raise "A FollowerThing command is already running. Try again later."
    end

    @last_command_running = true
    self.unfollow_non_followers
    self.followback
    @last_command_running = false
  end

  def unfollow_non_followers
    @client.following.each do |x|
      if !x.following?
        @client.unfollow(x)
        puts "Unfollowed #{x.screen_name}"
      end
      sleep(@delay)
    end
  end

  def followback
    @client.followers.each do |x|
      if x.following?
        @client.follow(x)
        puts "Followed #{x.screen_name}"
      end
      sleep(@delay)
    end
  end

  def unfollow_all
    @client.following.each do |x|
      @client.unfollow(x)
      puts "Unfollowed #{x.screen_name}"
      sleep(@delay)
    end
  end

  def follow_array(usernames = Array.new())
    usernames.each do |x|
      @client.follow(x)
      puts "Followed #{x}"
      sleep(@delay)
    end
  end

end

# YUMMY EXAMPLE
# Protip: use Thread class to multithread
#client = Twitter::REST::Client.new do |config|
#  config.consumer_key        = ""
#  config.consumer_secret     = ""
#  config.access_token        = ""
#  config.access_token_secret = ""
#end
#x = FollowerThing.new(client,'negatendo')
#x.follow_array(['twitter','logoninternet'])
