class RssFeedKeyword < ActiveRecord::Base
  belongs_to :rss_feed
  has_many :rss_feed_data, dependent: :destroy
  
  after_create :update_from_feed
  
  def update_from_feed
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
  

  def add_entries(entries, entry_id)
    entries.each do |entry|
      data = ::RssFeedDatum.where(url: entry.url).first_or_create(rss_feed_keyword_id: entry_id, guid: entry.id, name: entry.title, published_at: entry.published, blurb: get_html_content("#{entry.url}"))
    end
  end
  
  
  def get_html_content(requested_url)
    url = URI.parse(requested_url)
    full_path = (url.query.blank?) ? url.path : "#{url.path}?#{url.query}"
    the_request = Net::HTTP::Get.new(full_path)
    
    the_response = Net::HTTP.start(url.host, url.port) { |http|
      http.request(the_request)
    }
    if(the_response.response.code == "302")
      return get_html_content(the_response.response['Location'])
    else
      return the_response.body.delete("\n").delete("\r").delete("\t")
    end
  end   

end
