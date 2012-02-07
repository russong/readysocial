class RssFeedKeyword < ActiveRecord::Base
  belongs_to :rss_feed
  has_many :rss_feed_data, dependent: :destroy
  
  after_create :update_from_feed
  
  def update_from_feed#(feed_url)
    # puts "1"
    feed = Feedzirra::Feed.fetch_and_parse(self.rss_feed.url)
    # puts "2"
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
    # puts "3"
    entries.each do |entry|
      # puts "shit!"
      data = ::RssFeedDatum.where(url: entry.url).first_or_create( rss_feed_keyword_id: entry_id, guid: entry.id, name: entry.title, published_at: entry.published, blurb: get_html_content("#{entry.url}"))
      # data.blurb = get_html_content("#{entry.url}")
      # data.save
    end
    # ::RssFeedDatum.populate_trigram_index
  end
  
  
  def get_html_content(requested_url)
    # puts "fakkkk"
    # puts requested_url
    url = URI.parse(requested_url)
    full_path = (url.query.blank?) ? url.path : "#{url.path}?#{url.query}"
    the_request = Net::HTTP::Get.new(full_path)
    
    the_response = Net::HTTP.start(url.host, url.port) { |http|
      http.request(the_request)
    }
    # puts the_response.response.code
    if(the_response.response.code == "302")
      # puts the_response.response['Location']
      return get_html_content(the_response.response['Location'])
    else
      # puts the_response.body
      # puts the_response.code
    # raise "Response was not 200, response was #{the_response.code}" if the_response.code != "200"
      return the_response.body.delete("\n").delete("\r").delete("\t")
    end
  end   

  # # this will fail with ArgumentError: HTTP request path is empty
  # s = get_html_content("http://www.google.com")
  # # these should be fine
  # s = get_html_content("http://www.google.com/") 
  # s = get_html_content("http://github.com/search?q=http")
  # # above code does not handle redirects but raises exception for non-200 
  # s = get_html_content("http://www.yahoo.com/") # http 302
end
