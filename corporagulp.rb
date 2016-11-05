# encoding: utf-8
#!/usr/bin/ruby

require 'json'

class CorporaGulp
  # thing to navigate and assemble corpora data
  # see: https://github.com/dariusk/corpora

  attr_reader :data_dir, :data

  def initialize( path, folder, filename, property )
    # make sure we have a path to corpora
    if !File.directory? ( path )
      puts "Path to corpora must be a directory"
      exit
    else
      @data_dir = path + '/data/'
      begin
        file = JSON.parse(File.read(@data_dir + folder + '/' + filename))
      rescue
        puts "Could not read corpora data directory."
        exit
      end
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


#x = CorporaGulp.new('/home/bretto/corpora','animals','dogs.json','dogs')
#puts x.get_random
