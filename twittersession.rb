#!/usr/bin/ruby

class TwitterSession
  # thingy to track simple data about interaction sessions
  # with other users

  attr_reader :data #data will contain the ... data

  def initialize
    @data = {}
  end

  def add ( username, hash )
  end

end


# session = TwitterSession.new
# session.add('negatendo',{:poop => "things"})
# ...
# data = TwitterSession.lookup('negatendo')
# puts data
# session.clear('negatendo')
