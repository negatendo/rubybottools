#!/usr/bin/ruby

require 'pstore'

class TwitterSession
  # thingy to track persistant data about bot twitter interactions

  attr_reader :users #user interaction tracker stuffs
  attr_accessor :data #use this to store any old thing

  def initialize(name, path = '')
    @store = PStore.new(path + name + '.session.pstore')
    @data = @store.transaction { @store['data'] }
    @users = @store.transaction { @store['users'] }
  end

  def save_data(data)
    # er couldn't figure out how to not make a seperate "set"
    # for transactions? general session data
    self.save('data',data)
  end

  def data
    @data = @store.transaction { @store['data'] }
    return @data
  end

  def log_user_interaction( username )
    user = self.get_user( username )
    user.log_time()
    self.save('users',user.get_data_array())
  end

  def save_user_data( username, data )
    user = self.get_user( username )
    user.data = data
    self.save('users',user.get_data_array())
  end

  def get_user( username )
    @users = @store.transaction { @store['users'] }
    if @users
      this_user = @users[username]
      if this_user
        return TwitterSessionUser.new( username, this_user )
      end
    end
    # return new user obj if nothing
    return TwitterSessionUser.new( username )
  end

  def save(part,data)
    @store.transaction do
      @store[part] = data
      @store.commit
    end
  end

end

class TwitterSessionUser
  # seperate user class
  attr_reader :username
  attr_accessor :last_interaction_time, :data

  def initialize( username, existing_data = false )
    @username = username
    if existing_data
      @data = existing_data['data']
      @last_interaction_time = existing_data['last_interaction_time']
    else
      @data = { }
      @last_interaction_time = nil #that way we know no interactions
    end
  end

  # time logged is time since the great unix epoch PRAISE THE KERNEL
  def log_time
    @last_interaction_time = Time.now.to_i
  end

  def get_data_array
    # returns array ready for our pstore bits
    return { @username => { 'last_interaction_time' => @last_interaction_time, 'data' => @data } }
  end

end

# EXAMPLE
#session = TwitterSession.new(name = 'botname', path = '/home/bretto/')
#session.save_data({'poop' => 'shit'})
#puts session.data['poop']
#session.log_user_interaction('logoninternet')
#puts session.get_user('logoninternet').last_interaction_time
#data = { 'butt' => 'nozzles' }
#session.save_user_data('logoninternet',data)
#puts session.get_user('logoninternet').data

