#!/usr/bin/ruby

# thingy to gather information about followers and perform
# follow/unfollow actions

require 'twitter'
require_relative 'twurlrc-reader.rb'

# the delay between the refresh_follower crawlers actions
$twitter_client_delay = 5

class FollowerThing
  attr_accessor :client

  attr_reader :all_followers, :all_following

  def initialize(client, username = false, skip_refresh = false)
    # FEED ME TWITTER CLIENT and optional username to eat
    @client = client
    if !username
      username = client.user.screen_name
    end
    @delay = $twitter_client_delay

    # take back the user
    @username = username

    # set up all followers and following - this takes a while!
    # so you can skip it and manually call refresh_followers later ok?
    @all_following = Array.new
    @all_followers = Array.new
    if !skip_refresh
      self.refresh_followers
    end
  end

  def refresh_followers
    @all_following = self.crawl_all_following
    @all_followers = self.crawl_all_followers
  end

  def crawl_all_following
    @client.following.each do |x|
      puts "Info: following #{x.screen_name}"
      @all_following << x.screen_name
      sleep(@delay)
    end
  end

  def crawl_all_followers
    @client.followers.each do |x|
      puts "Info: followed by #{x.screen_name}"
      @all_followers << x.screen_name
      sleep(@delay)
    end
  end

  def follow_parity
    self.unfollow_non_followers
    self.followback
  end

  def unfollow_non_followers
    @all_followers.each do |x|
      if !x.following?
        @client.unfollow(x)
        puts "Unfollowed #{x.screen_name}"
      end
      sleep(@delay)
    end
  end

  def followback
    @all_followers.each do |x|
      if x.following?
        @client.follow(x)
        puts "Followed #{x.screen_name}"
      end
      sleep(@delay)
    end
  end

  def unfollow_all
    @all_following.each do |x|
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

  def unfollow_array(usernames = Array.new())
    usernames.each do |x|
      @client.follow(x)
      puts "Followed #{x}"
      sleep(@delay)
    end
  end

end

# EXAMPLE
# Protip: use Thread class to multithread
# init takes a long time as it loads up all your followers/following


account = TwurlrcReader.new('MarbleckaeYumte','lN1fHeFIm7LTAKQYV03DDpVNO')
client = account.get_rest_client()
x = FollowerThing.new(client,'negatendo')
x.follow_array(['twitter','logoninternet'])
