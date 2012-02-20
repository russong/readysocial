class HomeController < ApplicationController
  
  def index
    if request.post?
      # @search_rec = Search.create(:keywords => params[:text])
      @search_listing = Sunspot.search(RssFeedDatum) do |q|
        q.keywords  params[:text]
      end
      @listings = @search_listing.results
    end
    @keywords = Keyword.all
    @hash = {}
    page = (!params[:page].blank?)? params[:page] : 1
    logger.info page
    @keywords.each do |key|
      # url = URI.parse("http://search.twitter.com/search.json?q=#{CGI::escape(key.name)}&rpp=5&include_entities=true&result_type=mixed&page=#{page}")
      url = URI.parse("http://search.twitter.com/search.json?q=#{CGI::escape(key.name)}&result_type=mixed&page=#{page}")
      res = Net::HTTP.start(url.host, url.port) {|http|
        http.get("/search.json?q=#{CGI::escape(key.name)}&result_type=mixed&page=#{page}")
      }
      val = []
      if(res.class == Net::HTTPOK)
        json = JSON.parse(res.body)
        json["results"].each do |result|
          val << "#{result["from_user"]}:: #{result["text"]}"
          # val = val.join if val.class == Array
          RawDatum.where(blurb: result["text"], username: result["from_user"]).first_or_create(keyword_id: key.id)
        end
        @hash = @hash.merge!(key.name.to_sym => val)
      end
    end
  end
end

# "(\w+[and]?)" search for ""
