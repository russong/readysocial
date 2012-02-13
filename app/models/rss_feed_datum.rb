class RssFeedDatum < ActiveRecord::Base
  belongs_to :rss_feed_keyword
  
  searchable :auto_index => true, :auto_remove => true, :first_id => "a" do
    text    :blurb
  end
  # include NoFuzz
  # fuzzy :blurb
  
  #this returns an array of User objects
  # def self.fuzzy_search(search_term)
  #   results = RssFeedDatum.fuzzy_find(search_term, 10)
  # end
  # 
  # #this returns an active relation object
  # def self.search(search) 
  #   if search  
  #     user_ids = RssFeedDatum.fuzzy_find(search, 10)  
  #     where(["id IN (?)", user_ids])
  #   else  
  #     scoped  
  #   end  
  # end
  
end
