class RssFeedKeyword < ActiveRecord::Base
  belongs_to :rss_feed
  has_many :rss_feed_data
  
  after_create :update_from_feed
  
  def update_from_feed#(feed_url)
    feed = Feedzirra::Feed.fetch_and_parse(self.rss_feed.url)
    add_entries(feed.entries, self.id)
  end

  # def update_from_feed_continuously(feed_url, delay_interval = 15.minutes)
  #   feed = Feedzirra::Feed.fetch_and_parse(feed_url)
  #   add_entries(feed.entries)
  #   loop do
  #     sleep delay_interval
  #     feed = Feedzirra::Feed.update(feed)
  #     add_entries(feed.new_entries) if feed.updated?
  #   end
  # end

  private

  def add_entries(entries, entry_id)
    puts entry_id
    entries.each do |entry|

      ::RssFeedDatum.where(guid: entry.id).first_or_create(rss_feed_keyword_id: entry_id, name: entry.title, url: entry.url, published_at: entry.published)
      # unless exists? :guid => entry.id
      #   create!(
      #     :name         => entry.title,
      #     :summary      => entry.summary,
      #     :url          => entry.url,
      #     :published_at => entry.published,
      #     :guid         => entry.id
      #   )
      # end
    end
  end
  
end
