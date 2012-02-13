class RssFeed < ActiveRecord::Base
  has_many :rss_feed_keywords, dependent: :destroy
    
  def name
    self.url
  end
end
