#!/usr/bin/ruby

require 'yaml'
require 'twitter'

class TwurlrcReader
  #provide me username and consumer key and i'll return all the good stuff

  attr_reader :username, :consumer_key, :consumer_secret, :access_token, :access_token_secret

  attr_accessor :client

  def initialize(username, consumer_key)
    @path = ENV['HOME']+'/.twurlrc'
    @username = username
    @consumer_key = consumer_key
    #load our yaml and set rest of class variables
    profile = YAML.load_file(@path)['profiles'][@username][@consumer_key]
    @consumer_secret = profile['consumer_secret']
    @access_token = profile['token']
    @access_token_secret = profile['secret']
  end

  def get_rest_client
    # set up a twitter client if requested
    return Twitter::REST::Client.new do |config|
      config.consumer_key        = @consumer_key
      config.consumer_secret     = @consumer_secret
      config.access_token        = @access_token
      config.access_token_secret = @access_token_secret
    end
  end

end

#account = TwurlrcReader.new('MarbleckaeYumte','lN1fHeFIm7LTAKQYV03DDpVNO')
#puts account.username
#puts account.consumer_key
#puts account.consumer_secret
#puts account.access_token
#puts account.access_token_secret
#client = account.get_rest_client()
