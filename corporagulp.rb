# encoding: utf-8
#!/usr/bin/ruby

require 'json'

class CorporaGulp
  # thing to navigate and assemble corpora data
  # see: https://github.com/dariusk/corpora

  attr_reader :data_dir, :data

  def initialize( folder, filename, property )
    # make sure we have our data directory availabe
    if !File.directory? (File.dirname(__FILE__) + '/corpora')
      puts "Corpora not found. Did you init submodules?"
      exit
    else
      @data_dir = File.dirname(__FILE__) + '/corpora/data/'
      file = JSON.parse(File.read(@data_dir + folder + '/' + filename))
      @data = file[property]
    end
  end

  def get_all
    return @data
  end

  def get_random
    return @data.sample
  end

end


#x = CorporaGulp.new('animals','dogs.json','dogs')
#puts x.get_random
