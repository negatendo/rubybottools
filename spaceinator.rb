# encoding: utf-8
#!/usr/bin/ruby

class Spaceinator
  #returns specified number of spaces from an array of
  #different wacky unicode spaces - good for "seeecret padding"
  #of tweets to avoid duplicates/manager char limits

  #TODO: substitute spaces in a string

  attr_reader :spaces

  def initialize( )
    #thanks to http://www.cs.tut.fi/~jkorpela/chars/spaces.html
    @spaces = [
      "\u0020", #space
      "\u00A0", #no-break space
      "\u180E", #mongolian vowel seperator
      "\u2000", #en quad
      "\u2001", #em quad
      "\u2002", #en space
      "\u2003", #em space
      "\u2004", #three per em space
      "\u2005", #four per em space
      "\u2006", #six per em space
      "\u2007", #tabular width
      "\u2008", #punctuation space
      "\u2009", #thin space
      "\u200A", #hair space
      "\u200B", #zero width space
      "\u202F", #narrow no break space
      "\u205F", #medium mathematical space
      "\u3000", #ideographic space
      "\uFEFF", #zero width no break space
    ]
  end

  def get_spaces( num = 10 )
    #returns specified nubmer of random spaces
    num_found = 0
    str = ''
    while num_found <= num do
      str = str + @spaces.sample
      num_found += 1
    end
    return str
  end
end


#puts Spaceinator.new.get_spaces(30)
