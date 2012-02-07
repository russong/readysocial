class RssFeedDatum < ActiveRecord::Base
  belongs_to :rss_feed_keyword
  
  include NoFuzz
  fuzzy :blurb
  
  
  # def initialize
  #   super
  #   RssFeedDatum.populate_trigram_index
  # end
  
  #this returns an array of User objects
  def self.fuzzy_search(search_term)
    results = RssFeedDatum.fuzzy_find(search_term, 10)
  end
  
  #this returns an active relation object
  def self.search(search) 
    if search  
      user_ids = RssFeedDatum.fuzzy_find(search, 10)  
      where(["id IN (?)", user_ids])
    else  
      scoped  
    end  
  end
  
end
