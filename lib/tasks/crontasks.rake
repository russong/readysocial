namespace :cron do
  desc "pull data"
  task :pull_data => :environment do
    puts "RSS Start Count: #{RssFeedDatum.count}"
    puts "Twitter Start Count: #{RawDatum.count}"
    
    RssFeedKeyword.find_each do |keyword|
      puts "updating rss feed: #{keyword.name}"
      keyword.update_from_feed
    end
    1.upto(25).each do |i|
      puts "updating twitter feeds: #{i}"
      url = URI.parse("http://localhost:3000/?page=#{i}")
      res = Net::HTTP.start(url.host, url.port) do |http|
        http.get("/?page=#{i}")
      end
    end
    
    puts "RSS End Count: #{RssFeedDatum.count}"
    puts "Twitter End Count: #{RawDatum.count}"
  end
end

