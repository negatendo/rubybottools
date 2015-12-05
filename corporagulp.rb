# encoding: utf-8
#!/usr/bin/ruby

require 'linguistics'

class CorporaGulp
  #simple corpora json iterator with pluralizer and maybe other things
  def initalize
    @path = '~/Documents/corpora/data/animals/common.json'
    @pluralize = true
    #TODO set last word if bot crashes
    #@last_word = 'mice'
    @data = self.load_corpora
  end

  def load_corpora
    return JSON
  end

  def next_word
    #get the next word from the list
    #pluralize if requested
  end

end
