# encoding: utf-8
#!/usr/bin/ruby

require 'json'

class CorporaGulp
  # thing to navigate and assemble corpora data
  # see: https://github.com/dariusk/corpora

  Linguistics.use( :en )

  attr_reader :data_dir, :data

  def initialize
    # make sure we have our data directory availabe
    if !File.directory? (File.dirname(__FILE__) + '/corpora')
      puts "Corpora not found. Did you init submodules?"
      exit
    else
      @data_dir = File.dirname(__FILE__) + '/corpora/data/'
    end
  end

  def load( folder, filename, property )
    # loads into this object's data array the
    # property data specified in the folder and filename.json
    file = JSON.parse(File.read(@data_dir + folder + '/' + filename))
    @data = file[property]
  end

  def get_all
    return @data
  end

  def get_random
    return @data.sample
  end

end


#x = CorporaGulp.new
#x.load('animals','dogs.json','dogs')
#puts x.get_random
