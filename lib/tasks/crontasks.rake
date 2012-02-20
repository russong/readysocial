namespace :cron do
  desc "pull data"
  task :pull_data => :environment do
    RssFeedKeyword.find_each do |keyword|
      keyword.update_from_feed
    end
    1.upto(25).each do |i|
      url = URI.parse("http://localhost:3000/?page=#{i}")
      res = Net::HTTP.start(url.host, url.port) do |http|
        http.get("/?page=#{i}")
        puts i
      end
    end
  end
end

