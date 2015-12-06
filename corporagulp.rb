# encoding: utf-8
#!/usr/bin/ruby

#TODO: make me work on json files with more than one property

require 'linguistics'
require 'json'

class CorporaGulp
  #simple corpora json iterator with pluralizer and maybe other things

  attr_reader :data #data will contain the ... data

  Linguistics.use( :en )

  def initialize(path,resource)
    #corpora dir + rest of path to json
    @full_path = path + "data" + resource + ".json"
    #read in raw data
    @data = JSON.parse(File.read(@full_path))
    @iterators = {} #shifted arrays of each iterated property
  end

  def get_next( property, pluralize )
    #see if already tracking this property
    if !@iterators.include? property
      @iterators[property] = @data[ property ]
    end
    return @iterators["vegetables"].shift
  end

  def get_all(property,pluralize)
  end

  def get_random( property, pluralize )
    #random specified property from data
    sample = @data[property].sample
    if pluralize
      return sample.en.plural
    else
      return sample
    end
  end

end


#vegetables = CorporaGulp.new('/home/bretto/Documents/corpora/','/foods/vegetables')
#puts vegetables.data
#i = 0
#while i < 100 do
#  i += 1
#  veg = vegetables.get_next('vegetables',true)
#  if veg
#    puts veg
#  else
#    exit
#  end
#end
#puts vegetables.get_random('vegetables',true)
